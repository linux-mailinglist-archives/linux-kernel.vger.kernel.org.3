Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED81B46F647
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 22:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhLIWBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:01:08 -0500
Received: from relay028.a.hostedemail.com ([64.99.140.28]:31993 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231868AbhLIWBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:01:07 -0500
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay13.hostedemail.com (Postfix) with ESMTP id 60AD2607F3;
        Thu,  9 Dec 2021 21:57:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 15E586000E;
        Thu,  9 Dec 2021 21:57:21 +0000 (UTC)
Message-ID: <4208b3d08a677601c73889f78dd25e5c9f056a86.camel@perches.com>
Subject: Re: [PATCH] scsi: elx: efct: Avoid a useless memset
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        james.smart@broadcom.com, ram.vegesna@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.de,
        dwagner@suse.de
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Thu, 09 Dec 2021 13:57:21 -0800
In-Reply-To: <009cddb72f4a1b6d1744d5a8ab1955eb93509e41.1639086550.git.christophe.jaillet@wanadoo.fr>
References: <009cddb72f4a1b6d1744d5a8ab1955eb93509e41.1639086550.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.04
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 15E586000E
X-Stat-Signature: qswf1qmnu8z4by5p3d9f3e3n8894okrx
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/OSLtqe4qK/nd1NuH+QXDkDyHLdhak/ds=
X-HE-Tag: 1639087041-129798
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-09 at 22:51 +0100, Christophe JAILLET wrote:
> 'io->sgl' is kzalloced just a few lines above. There is no need to memset
> it another time.

Better to use kcalloc as well and delete the memset

> diff --git a/drivers/scsi/elx/efct/efct_io.c b/drivers/scsi/elx/efct/efct_io.c
[]
> @@ -62,7 +62,6 @@ efct_io_pool_create(struct efct *efct, u32 num_sgl)
>  			return NULL;
>  		}
>  
> -		memset(io->sgl, 0, sizeof(*io->sgl) * num_sgl);
>  		io->sgl_allocated = num_sgl;
>  		io->sgl_count = 0;
>  

---
 drivers/scsi/elx/efct/efct_io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/elx/efct/efct_io.c b/drivers/scsi/elx/efct/efct_io.c
index 71e21655916a9..109483f3e3dfd 100644
--- a/drivers/scsi/elx/efct/efct_io.c
+++ b/drivers/scsi/elx/efct/efct_io.c
@@ -56,13 +56,12 @@ efct_io_pool_create(struct efct *efct, u32 num_sgl)
 		}
 
 		/* Allocate SGL */
-		io->sgl = kzalloc(sizeof(*io->sgl) * num_sgl, GFP_KERNEL);
+		io->sgl = kcalloc(num_sgl, sizeof(*io->sgl), GFP_KERNEL);
 		if (!io->sgl) {
 			efct_io_pool_free(io_pool);
 			return NULL;
 		}
 
-		memset(io->sgl, 0, sizeof(*io->sgl) * num_sgl);
 		io->sgl_allocated = num_sgl;
 		io->sgl_count = 0;
 


