Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B931528CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344687AbiEPSRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238321AbiEPSRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:17:49 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9B12AC77
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:17:46 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id i8so1286919plr.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uT/H9lZy9IyzIRo1BQPyvaimIM9+75W3QLmIxSLbuUU=;
        b=X/dO4kHPPX6KVzqik98XxhX4qe4Hr1GB5v1Wpz0rg5kveBi8fb1EaSY3qqpBdekATl
         WmSUzbMAG4lMNQM42rPgDMUMefvuggeIOojhi9gZIEnpXsnzXBaXl4TH3em8ry7dOLT4
         HfLQkYE7bIugkTRczU3iNdQSDYZ4PsuA4zJhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uT/H9lZy9IyzIRo1BQPyvaimIM9+75W3QLmIxSLbuUU=;
        b=H0W4YF07AWmThK8aQMClRRNs/tHeTt80aXJRHYkiSOtyg71KPTzZMHmItQyRISw+RX
         PCjNrCBcOJxr6BjF4moBTuZbs15wh1ub4PGPj0YLeuQmtEuGeF3PXDv0SwlEaQuJwOxG
         cxgN/Ap5BXqL3qjK7jR3eDvPx+2xbb4wjvjDvGyz5o1AQnDYU+7QEMGqYNzthAkY+TqN
         KPGZV2mbf/93Q6rccHVKMH5XXFCMHfRNquE2rTZv5GRfmK1voWrGSkm5a1kbcpnnu0UM
         OaAbpQN5WJVdfOd/7LOfX6oteSEpzOzrj2Q7JA/B5AO+oEdWGMiB3+ChVuOBA1BwjyOS
         mmWw==
X-Gm-Message-State: AOAM532CZZqzO5BVpE8BXbmq1l6/0oo1f1PLozMyShj/1Gx+IuhpV/dx
        BoI82msJzaqwo5JSHW0MkGL3gg==
X-Google-Smtp-Source: ABdhPJwB7aNz9FzyraE3HZ214E4qpUBNZvJ5G0yqjEDlZDbTxbrjUI8/xzb3tlOkPTBXN2yurcWawg==
X-Received: by 2002:a17:902:b906:b0:158:3120:3b69 with SMTP id bf6-20020a170902b90600b0015831203b69mr18435617plb.33.1652725066427;
        Mon, 16 May 2022 11:17:46 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:4ee0:ca4c:63fd:81d2])
        by smtp.gmail.com with UTF8SMTPSA id p11-20020a170902e74b00b0015e8d4eb1d8sm7431343plf.34.2022.05.16.11.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 11:17:46 -0700 (PDT)
Date:   Mon, 16 May 2022 11:17:44 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/3] LoadPin: Enable loading from trusted dm-verity
 devices
Message-ID: <YoKVSEJyHvFg/V9+@google.com>
References: <20220504195419.1143099-1-mka@chromium.org>
 <20220504125404.v3.2.I01c67af41d2f6525c6d023101671d7339a9bc8b5@changeid>
 <B7FB2BE6-DF1C-414A-B4C2-0C15FD1CBF75@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <B7FB2BE6-DF1C-414A-B4C2-0C15FD1CBF75@chromium.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

thanks for the review!

On Fri, May 13, 2022 at 03:36:26PM -0700, Kees Cook wrote:
> 
> 
> On May 4, 2022 12:54:18 PM PDT, Matthias Kaehlcke <mka@chromium.org> wrote:
> >Extend LoadPin to allow loading of kernel files from trusted dm-verity [1]
> >devices.
> >
> >This change adds the concept of trusted verity devices to LoadPin. LoadPin
> >maintains a list of root digests of verity devices it considers trusted.
> >Userspace can populate this list through an ioctl on the new LoadPin
> >securityfs entry 'dm-verity'. The ioctl receives a file descriptor of
> >a file with verity digests as parameter. Verity reads the digests from
> >this file after confirming that the file is located on the pinned root.
> >The list of trusted digests can only be set up once, which is typically
> >done at boot time.
> >
> >When a kernel file is read LoadPin first checks (as usual) whether the file
> >is located on the pinned root, if so the file can be loaded. Otherwise, if
> >the verity extension is enabled, LoadPin determines whether the file is
> >located on a verity backed device and whether the root digest of that
> 
> I think this should be "... on an already trusted device ..."

It's not entirely clear which part you want me to substitute. 'an already
trusted device' makes me wonder whether you are thinking about reading the
list of digests, and not the general case of reading a kernel file, which
this paragraph intends to describe.

> >device is in the list of trusted digests. The file can be loaded if the
> >verity device has a trusted root digest.
> >
> >Background:
> >
> >As of now LoadPin restricts loading of kernel files to a single pinned
> >filesystem, typically the rootfs. This works for many systems, however it
> >can result in a bloated rootfs (and OTA updates) on platforms where
> >multiple boards with different hardware configurations use the same rootfs
> >image. Especially when 'optional' files are large it may be preferable to
> >download/install them only when they are actually needed by a given board.
> >Chrome OS uses Downloadable Content (DLC) [2] to deploy certain 'packages'
> >at runtime. As an example a DLC package could contain firmware for a
> >peripheral that is not present on all boards. DLCs use dm-verity to verify
> >the integrity of the DLC content.
> >
> >[1] https://www.kernel.org/doc/html/latest/admin-guide/device-mapper/verity.html
> >[2] https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/dlcservice/docs/developer.md
> >
> >Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> >---
> >
> >Changes in v3:
> >- added securityfs for LoadPin (currently only populated when
> >  CONFIG_SECURITY_LOADPIN_VERITY=y)
> >- added uapi include for LoadPin
> >- changed the interface for setting up the list of trusted
> >  digests from sysctl to ioctl on securityfs entry
> >- added stub for loadpin_is_fs_trusted() to be used
> >  CONFIG_SECURITY_LOADPIN_VERITY is not select
> >- depend on CONFIG_SECURITYFS instead of CONFIG_SYSTCL
> >- updated Kconfig help
> >- minor changes in read_trusted_verity_root_digests()
> >- updated commit message
> >
> >Changes in v2:
> >- userspace now passes the path of the file with the verity digests
> >  via systcl, instead of the digests themselves
> >- renamed sysctl file to 'trusted_verity_root_digests_path'
> >- have CONFIG_SECURITY_LOADPIN_VERITY depend on CONFIG_SYSCTL
> >- updated Kconfig doc
> >- updated commit message
> >
> > include/uapi/linux/loadpin.h |  19 ++++
> > security/loadpin/Kconfig     |  16 +++
> > security/loadpin/loadpin.c   | 184 ++++++++++++++++++++++++++++++++++-
> > 3 files changed, 218 insertions(+), 1 deletion(-)
> > create mode 100644 include/uapi/linux/loadpin.h
> >
> >diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> >index b12f7d986b1e..c29ce562a366 100644
> >--- a/security/loadpin/loadpin.c
> >+++ b/security/loadpin/loadpin.c
>
> ...
>
> >+static int read_trusted_verity_root_digests(unsigned int fd)
> >+{
> >+	struct fd f;
> >+	void *data;
> 
> Probably easier if this is u8 *?

Maybe slightly, it would then require a cast when passing it to
kernel_read_file()

> >+	int rc;
> >+	char *p, *d;
> >+
> >+	/* The list of trusted root digests can only be set up once */
> >+	if (!list_empty(&trusted_verity_root_digests))
> >+		return -EPERM;
> >+
> >+	f = fdget(fd);
> >+	if (!f.file)
> >+		return -EINVAL;
> >+
> >+	data = kzalloc(SZ_4K, GFP_KERNEL);
> >+	if (!data) {
> >+		rc = -ENOMEM;
> >+		goto err;
> >+	}
> >+
> >+	rc = kernel_read_file(f.file, 0, &data, SZ_4K - 1, NULL, READING_POLICY);
> >+	if (rc < 0)
> >+		goto err;
> >+
> >+	((char *)data)[rc] = '\0';
> >+
> >+	p = strim(data);
> >+	while ((d = strsep(&p, ",")) != NULL) {
> 
> Maybe be flexible and add newline as a separator too?

Sure, I can add that. I'd also be fine with just allowing a newline as
separator, which seems a reasonable format for a sysfs file.

> >+		int len = strlen(d);
> >+		struct trusted_root_digest *trd;
> >+
> >+		if (len % 2) {
> >+			rc = -EPROTO;
> >+			goto err;
> >+		}
> >+
> >+		len /= 2;
> >+
> >+		trd = kzalloc(sizeof(*trd), GFP_KERNEL);
> 
> With the struct change, this could be:
> 
> kzalloc(struct_size(trd, data, len), ...)

Will change

> >+		if (!trd) {
> >+			rc = -ENOMEM;
> >+			goto err;
> >+		}
> >+
> >+		trd->data = kzalloc(len, GFP_KERNEL);
> >+		if (!trd->data) {
> >+			kfree(trd);
> >+			rc = -ENOMEM;
> >+			goto err;
> >+		}
> >+
> >+		if (hex2bin(trd->data, d, len)) {
> >+			kfree(trd);
> >+			kfree(trd->data);
> >+			rc = -EPROTO;
> >+			goto err;
> >+		}
> >+
> >+		trd->len = len;
> >+
> >+		list_add_tail(&trd->node, &trusted_verity_root_digests);
> >+	}
> >+
> >+	kfree(data);
> >+	fdput(f);
> >+
> >+	if (!list_empty(&trusted_verity_root_digests))
> >+		dm_verity_loadpin_set_trusted_root_digests(&trusted_verity_root_digests);
> >+
> >+	return 0;
> >+
> >+err:
> >+	kfree(data);
> >+
> 
> Maybe add a comment that any load failure will invalidate the entire list?

ok

> Otherwise looks good! The only other thing I can think of is pondering more
> about more carefully failing closed. E.g. instead of just throwing away all
> the other hashes on a file load failure, maybe lock out future attempts to
> set it too? I'm not sure this is actually useful, though. :P it shouldn't be
> possible to corrupt the file, etc. But in the universe where things like
> DirtyCOW happens, I've gotten even more paranoid. ;)

Sure, we can do that
