Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7984BE706
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356157AbiBULVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:21:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356395AbiBULVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:21:06 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958292195
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 03:11:51 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z22so28580167edd.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 03:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mZK3sq6aCOHjPE/wikruaHnKvlqiGOa64aJPVy9I1wc=;
        b=qV8+5WSPKScehLKtlkkkCIXQYywQ3YFx/N/gs5DkozC+Euq35Yxjydk1dU/ABDn18t
         9Y6t+u2sNVo6gasjPHp+8r2VlqZAybV0kVF+ABBbG1qb+oOT93BH4fg7dl/mh7eQTjey
         8ovdEUMqE4pnjXV+r89bY+vgajbp7hhnD+cAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mZK3sq6aCOHjPE/wikruaHnKvlqiGOa64aJPVy9I1wc=;
        b=X/vcqWtrE6pQ4ZPszSRKCAE/C0W8J0xK/yPsKlNmnnRtVkXLnmgzcol/kVfpUdL1Wy
         6APTcnPlegpy5VOC35poAQbxEtX1z2twUFxFhRMFuO4szmURze/kWvuot4/X8+tOXbmO
         /E1oO5GiPqA827+1hns84wyIBpxPnt6W1KcJ96LAnGUQlU+X/+8yQLQHDLRWc9gAeHFg
         HCIwhGZAx+Wq9l7RCRvsOn1QqDbOEyIzg4Ak1Q+0chUn+dJnNps8h+CjL0xCQ5gjQds/
         CihpBnvgrVMWhKusBP823s0MR51bUdZCeNfxGpigWz93GBQOcqDr94PXws4MzegCxjKz
         xmfQ==
X-Gm-Message-State: AOAM532WUF7cpj9CWwrGS0vCIszIrM4f56A9M5yxsz+KF+z8j8jsiAg9
        eTPU7xv5KrHB7BRvorc5XCqadg==
X-Google-Smtp-Source: ABdhPJxJzcjLPzJzGYO9f0nhLLry7CASSgSeVyxigW4CfvIOhfF9RUUR+7eq3ZIvVTYPfwQocOekqw==
X-Received: by 2002:a05:6402:d08:b0:412:a33e:24fe with SMTP id eb8-20020a0564020d0800b00412a33e24femr21029638edb.281.1645441910177;
        Mon, 21 Feb 2022 03:11:50 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-178-48-189-3.catv.fixed.vodafone.hu. [178.48.189.3])
        by smtp.gmail.com with ESMTPSA id ay16sm2462214ejb.61.2022.02.21.03.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 03:11:49 -0800 (PST)
Date:   Mon, 21 Feb 2022 12:11:47 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Alois Wohlschlager <alois1@gmx-topmail.de>
Cc:     linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ovl: warn if trusted xattr creation fails
Message-ID: <YhNzc/++SHzdMXyt@miu.piliscsaba.redhat.com>
References: <2783448.iqOl4yHqVZ@genesis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2783448.iqOl4yHqVZ@genesis>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 12:02:46PM +0100, Alois Wohlschlager wrote:
> When mounting overlayfs in an unprivileged user namespace, trusted xattr
> creation will fail. This will lead to failures in some file operations,
> e.g. in the following situation:
> 
>   mkdir lower upper work merged
>   mkdir lower/directory
>   mount -toverlay -olowerdir=lower,upperdir=upper,workdir=work none merged
>   rmdir merged/directory
>   mkdir merged/directory
> 
> The last mkdir will fail:
> 
>   mkdir: cannot create directory 'merged/directory': Input/output error
> 
> The cause for these failures is currently extremely non-obvious and hard
> to debug. Hence, warn the user and suggest using the userxattr mount
> option, if it is not already supplied and xattr creation fails during
> the self-check.

Thanks for the patch.

How about the following (untested) variant?

Thanks,
Miklos


diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 7bb0a47cb615..955aeefc3b29 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1413,11 +1413,12 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 	 */
 	err = ovl_do_setxattr(ofs, ofs->workdir, OVL_XATTR_OPAQUE, "0", 1);
 	if (err) {
+		pr_warn("failed to set xattr on upper\n");
 		ofs->noxattr = true;
 		if (ofs->config.index || ofs->config.metacopy) {
 			ofs->config.index = false;
 			ofs->config.metacopy = false;
-			pr_warn("upper fs does not support xattr, falling back to index=off,metacopy=off.\n");
+			pr_warn("...falling back to index=off,metacopy=off.\n");
 		}
 		/*
 		 * xattr support is required for persistent st_ino.
@@ -1425,8 +1426,10 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 		 */
 		if (ofs->config.xino == OVL_XINO_AUTO) {
 			ofs->config.xino = OVL_XINO_OFF;
-			pr_warn("upper fs does not support xattr, falling back to xino=off.\n");
+			pr_warn("...falling back to xino=off.\n");
 		}
+		if (err == -EPERM && !ofs->config.userxattr)
+			pr_info("try mounting with 'userxattr' option\n");
 		err = 0;
 	} else {
 		ovl_do_removexattr(ofs, ofs->workdir, OVL_XATTR_OPAQUE);
