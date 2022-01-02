Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19F1482C88
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 19:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiABSGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 13:06:49 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:39802 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiABSGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 13:06:36 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 65756201413;
        Sun,  2 Jan 2022 18:06:31 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id EFA16806AF; Sun,  2 Jan 2022 18:52:19 +0100 (CET)
Date:   Sun, 2 Jan 2022 18:52:19 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: pcmcia_resource: return 0 if success
Message-ID: <YdHmUw4id8QpQusE@owl.dominikbrodowski.net>
References: <20211212075630.349459-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211212075630.349459-1-wangborong@cdjrlc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sun, Dec 12, 2021 at 03:56:30PM +0800 schrieb Jason Wang:
> The initial value of variable `ret' is -EINVAL, which is used for
> returning the error status in `pcmcia_release_io' when errors occur.
> But if there is no error in `pcmcia_release_io', `ret' should be changed
> to a successful value to return. Thus we change `ret' value to 0 when
> the function's status is successful.

Thanks for your patch! However, the sole user of pcmcia_release_io() is
not interested in the return value anyway. Therefore, I'd suggest the
following.

Thanks,
	Dominik


pcmcia: make pcmcia_release_io() void, as no-one is interested in return value

As the only user of pcmcia_release_io() is not interested in its return
value, and we cannot do anything on failure, convert the function to return
void.

Reported-by: Jason Wang <wangborong@cdjrlc.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/drivers/pcmcia/pcmcia_resource.c b/drivers/pcmcia/pcmcia_resource.c
index c1c197292111..d78091e79a0f 100644
--- a/drivers/pcmcia/pcmcia_resource.c
+++ b/drivers/pcmcia/pcmcia_resource.c
@@ -390,10 +390,9 @@ int pcmcia_release_configuration(struct pcmcia_device *p_dev)
  * "stale", we don't bother checking the port ranges against the
  * current socket values.
  */
-static int pcmcia_release_io(struct pcmcia_device *p_dev)
+static void pcmcia_release_io(struct pcmcia_device *p_dev)
 {
 	struct pcmcia_socket *s = p_dev->socket;
-	int ret = -EINVAL;
 	config_t *c;
 
 	mutex_lock(&s->ops_mutex);
@@ -412,8 +411,6 @@ static int pcmcia_release_io(struct pcmcia_device *p_dev)
 
 out:
 	mutex_unlock(&s->ops_mutex);
-
-	return ret;
 } /* pcmcia_release_io */
 
 
