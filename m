Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF6347DF12
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 07:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242345AbhLWGew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 01:34:52 -0500
Received: from verein.lst.de ([213.95.11.211]:52790 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232444AbhLWGet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:34:49 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D92A168AFE; Thu, 23 Dec 2021 07:34:46 +0100 (CET)
Date:   Thu, 23 Dec 2021 07:34:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jackie Liu <liuyun01@kylinos.cn>
Subject: Re: [PATCH] scsi: bsg: Ignore bsg queue registration failures again
Message-ID: <20211223063446.GA4005@lst.de>
References: <20211222165427.1855582-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222165427.1855582-1-linux@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 08:54:27AM -0800, Guenter Roeck wrote:
> Since commit 5f7cf82c1d73 ("scsi: bsg: Fix errno when
> scsi_bsg_register_queue() fails"), errors from registering the bsg queue
> are no longer ignored but returned to the caller. At the same time, the
> comment in the code still states that errors are ignored. On top of that,
> the message preporting the problem is printed as dev_info, not dev_err.
> Both suggest that errors from bsg queue registrations should indeed be
> ignored.

But there is no good reason to ignore it.  The proper fix is to fully
handle the errors.
