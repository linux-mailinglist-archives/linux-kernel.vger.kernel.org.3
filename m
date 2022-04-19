Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CCB50797F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiDSS7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiDSS7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:59:44 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242E2633B;
        Tue, 19 Apr 2022 11:56:59 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id r85so13938906oie.7;
        Tue, 19 Apr 2022 11:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yQtGKgzPRTycXEWITpVvJvOYs166VoDlVcAFAi1dcgQ=;
        b=n5UdN9nx9FMhCFN4lrh0QUQL7EIinZjd6Ym0sNnGEduLD2P+gM/5ZR2fEBwHAqltBd
         z2Hp2edkn/MHMd9tsxPGD28Akp30stWyrXGyCr42hOb0AIBMJBD3O+Vvq63cs8Bx16vu
         CdrOFm2Ko166QRq28+NdzOk4RcUDGLgFERnkTA9Kq3TiypgNo0WOGFXnga7DUUpGAUoQ
         Rf85RA7ux9wUwv6Hxa3kLfH5uki3Y8f1G+l/R14BN0JhYXXCircmeMnkJEp8RLwYWMr+
         k/FIR7MtajWUpL0De7sKhySmsEzry6/9gDm65yATJ+xEH3YcFNF1mv+jl+A6B7Sx0TeI
         /USQ==
X-Gm-Message-State: AOAM533p31kTs0CHFXl7jvt04LBpjiRWQqrJt7PvuTRAxzsNGKUNhFll
        xpvX9WlS0TysdLFaPMqS7w==
X-Google-Smtp-Source: ABdhPJyr3p9PP742UwuTVdfZCAuXoG6/PVVZjmKFhDBb7QXGt6uyIgDlEgZEwKPM+7YR5FFoYm1ZHw==
X-Received: by 2002:a05:6808:1490:b0:2f9:d1fb:273b with SMTP id e16-20020a056808149000b002f9d1fb273bmr29597oiw.20.1650394618395;
        Tue, 19 Apr 2022 11:56:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bp21-20020a056820199500b003298e6877c7sm5576841oob.29.2022.04.19.11.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:56:57 -0700 (PDT)
Received: (nullmailer pid 3152167 invoked by uid 1000);
        Tue, 19 Apr 2022 18:56:57 -0000
Date:   Tue, 19 Apr 2022 13:56:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     pantelis.antoniou@konsulko.com,
        Slawomir Stepien <slawomir.stepien@nokia.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slawomir Stepien <sst@poczta.fm>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
Subject: Re: [PATCH v3 2/2] of: overlay: rework overlay apply and remove
 kfree()s
Message-ID: <Yl8F+cthdYbDBdWX@robh.at.kernel.org>
References: <20220419005241.831411-1-frowand.list@gmail.com>
 <20220419005241.831411-3-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419005241.831411-3-frowand.list@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 07:52:41PM -0500, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Fix various kfree() issues related to of_overlay_apply().
>   - Double kfree() of fdt and tree when init_overlay_changeset()
>     returns an error.
>   - free_overlay_changeset() free the root of the unflattened
>     overlay (variable tree) instead of the memory that contains
>     the unflattened overlay.
>   - For the case of a failure during applying an overlay, move kfree()
>     of new_fdt and overlay_mem into free_overlay_changeset(), which
>     is called by the function that allocated them.
>   - For the case of removing an overlay, the kfree() of new_fdt and
>     overlay_mem remains in free_overlay_changeset().

You never set kfree_unsafe back to false anywhere, so after removing you 
still leak memory.

>   - Check return value of of_fdt_unflatten_tree() for error instead
>     of checking the returned value of overlay_root.
>   - When storing pointers to allocated objects in ovcs, do so as
>     near to the allocation as possible instead of in deeply layered
>     function.
> 
> More clearly document policy related to lifetime of pointers into
> overlay memory.
> 
> Double kfree()
> Reported-by: Slawomir Stepien <slawomir.stepien@nokia.com>
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> Changes since v2:
>   - A version 2 review comment correctly said "This screams hack".
>     Restructure as listed below in response to the comment.
>   - Quit passing kfree_unsafe in function parameters, move it to
>     be a field of ovcs

What I meant was store the notifier state and from that imply when kfree 
is unsafe. Something like this patch on top of yours (untested and still 
some kfree_unsafe comments need to be updated):

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 3072dfeca8e8..53c616f576d2 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -63,7 +63,7 @@ struct fragment {
  * @count:		count of fragment structures
  * @fragments:		fragment nodes in the overlay expanded device tree
  * @symbols_fragment:	last element of @fragments[] is the  __symbols__ node
- * @kfree_unsafe:	pointers into the @new_fdt or @overlay_mem may exist
+ * @notify_state:	the last successful notifier called
  * @cset:		changeset to apply fragments to live device tree
  */
 struct overlay_changeset {
@@ -75,7 +75,7 @@ struct overlay_changeset {
 	int count;
 	struct fragment *fragments;
 	bool symbols_fragment;
-	bool kfree_unsafe;
+	enum of_overlay_notify_action notify_state;
 	struct of_changeset cset;
 };
 
@@ -183,6 +183,8 @@ static int overlay_notify(struct overlay_changeset *ovcs,
 		}
 	}
 
+	ovcs->notify_state = action;
+
 	return 0;
 }
 
@@ -831,6 +833,7 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs)
 	}
 
 	ovcs->count = cnt;
+	ovcs->notify_state = OF_OVERLAY_INIT;
 
 	return 0;
 
@@ -866,15 +869,14 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
 	 * allowed to retain pointers into the overlay devicetree other
 	 * than during the window between OF_OVERLAY_PRE_APPLY overlay
 	 * notifiers and the OF_OVERLAY_POST_REMOVE overlay notifiers.
-	 * During the window, ovcs->kfree_unsafe will be true.
 	 *
 	 * A memory leak will occur here if ovcs->kfree_unsafe is true.
 	 */
 
-	if (!ovcs->kfree_unsafe)
+	if (ovcs->notify_state == OF_OVERLAY_INIT || ovcs->notify_state == OF_OVERLAY_POST_REMOVE) {
 		kfree(ovcs->overlay_mem);
-	if (!ovcs->kfree_unsafe)
 		kfree(ovcs->new_fdt);
+	}
 	kfree(ovcs);
 }
 
@@ -926,12 +928,6 @@ static int of_overlay_apply(struct overlay_changeset *ovcs)
 	if (ret)
 		goto out;
 
-	/*
-	 * After overlay_notify(), ovcs->overlay_root related pointers may have
-	 * leaked to drivers, so can not kfree() ovcs->overlay_mem and
-	 * ovcs->new_fdt until after OF_OVERLAY_POST_REMOVE notifiers.
-	 */
-	ovcs->kfree_unsafe = true;
 	ret = overlay_notify(ovcs, OF_OVERLAY_PRE_APPLY);
 	if (ret) {
 		pr_err("overlay changeset pre-apply notify error %d\n", ret);
diff --git a/include/linux/of.h b/include/linux/of.h
index 04971e85fbc9..b7b095593eec 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1543,6 +1543,7 @@ static inline bool of_device_is_system_power_controller(const struct device_node
  */
 
 enum of_overlay_notify_action {
+	OF_OVERLAY_INIT = -1,
 	OF_OVERLAY_PRE_APPLY = 0,
 	OF_OVERLAY_POST_APPLY,
 	OF_OVERLAY_PRE_REMOVE,
