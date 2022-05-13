Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B529526CDE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 00:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiEMWQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 18:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiEMWP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 18:15:58 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB84366A7
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 15:15:57 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n10so9195557pjh.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 15:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=8evsmsRgEXU9i1Zu7hcfNtENF1tNp6TzzC6MYoPKnsk=;
        b=ACiA+mJBn1zPkljWby6aEhgTay+D3sOEiKQYtAHhue81w6Mofhw5GJfsjdGVg4wLWC
         e7V6Nl5BDTq2NVbU34qCbPQaDHCMnvRzc0p8L+vFcNgWQ8+sPAOvdgi5GrecqEBC+HFZ
         OD4FyT5oSwe4F2LKRi5nerYkcLX2G8Up11jYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=8evsmsRgEXU9i1Zu7hcfNtENF1tNp6TzzC6MYoPKnsk=;
        b=jrFYx/XPtsEP46bcrD7kaDByZQF1+n92prpoWXsoEKlBiViSWZ9yUxxyboUm4FJkMs
         uCMePZkZyaGlQVUPpkbpicVqO5kmSAqt4Vj7HPHBjkZyKkS9lsspVgVlLHHltxe+85Ot
         aYNHUZIksgezF6YGA2JcWr4+g2x6WXzENTcfDgZwmA6HFssW9pN8FvYXSOM91yuQ81qi
         qROYOQs62b7teVTN0Jp7cQvhE3fRn9VeiSlbnQ+XVRzN7pkKE9i+/ol7DHGFGwkRRKqq
         6xCb3X0hRp31qN1u1h+q2ZUnSWE9MysdIfGZSF0aprxnQtbfhOD426HY+sZW5KrWGQfN
         ps4A==
X-Gm-Message-State: AOAM532mXyEmio9nGg/f2FMPjYrTBXUXzodH2HDU0k9JcsBsFTxYFTdF
        iBfeMuIXVA9bezaiYNQV2g87jg==
X-Google-Smtp-Source: ABdhPJzSxU8Q1LxQ0CmSrYrip2cEiTE+YGFGKC8YEWo6YSG9RKpU6dCkHklOK9FqXRrmHa5BpMjYhA==
X-Received: by 2002:a17:90a:b78d:b0:1d9:4f4f:bc2a with SMTP id m13-20020a17090ab78d00b001d94f4fbc2amr18247100pjr.155.1652480156857;
        Fri, 13 May 2022 15:15:56 -0700 (PDT)
Received: from ?IPv6:::1? ([2607:fb90:3322:7d68:6474:9b3c:2c42:56f1])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902d4cc00b0015ebb3bf277sm2375659plg.238.2022.05.13.15.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 15:15:56 -0700 (PDT)
Date:   Fri, 13 May 2022 15:15:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
CC:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dm: Add verity helpers for LoadPin
User-Agent: K-9 Mail for Android
In-Reply-To: <20220504125404.v3.1.I3e928575a23481121e73286874c4c2bdb403355d@changeid>
References: <20220504195419.1143099-1-mka@chromium.org> <20220504125404.v3.1.I3e928575a23481121e73286874c4c2bdb403355d@changeid>
Message-ID: <02028CEA-5704-4A51-8CAD-BEE53CEF7CCA@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On May 4, 2022 12:54:17 PM PDT, Matthias Kaehlcke <mka@chromium=2Eorg> wro=
te:
>LoadPin limits loading of kernel modules, firmware and certain
>other files to a 'pinned' file system (typically a read-only
>rootfs)=2E To provide more flexibility LoadPin is being extended
>to also allow loading these files from trusted dm-verity
>devices=2E For that purpose LoadPin can be provided with a list
>of verity root digests that it should consider as trusted=2E
>
>Add a bunch of helpers to allow LoadPin to check whether a DM
>device is a trusted verity device=2E The new functions broadly
>fall in two categories: those that need access to verity
>internals (like the root digest), and the 'glue' between
>LoadPin and verity=2E The new file dm-verity-loadpin=2Ec contains
>the glue functions=2E
>
>Signed-off-by: Matthias Kaehlcke <mka@chromium=2Eorg>
> [=2E=2E=2E]
>diff --git a/drivers/md/dm-verity-loadpin=2Ec b/drivers/md/dm-verity-load=
pin=2Ec
>new file mode 100644
>index 000000000000=2E=2E972ca93a2231
>--- /dev/null
>+++ b/drivers/md/dm-verity-loadpin=2Ec
>@@ -0,0 +1,80 @@
>+// SPDX-License-Identifier: GPL-2=2E0-only
>+
>+#include <linux/list=2Eh>
>+#include <linux/kernel=2Eh>
>+#include <linux/dm-verity-loadpin=2Eh>
>+
>+#include "dm=2Eh"
>+#include "dm-verity=2Eh"
>+
>+static struct list_head *trusted_root_digests;

Does this need to exist in two places? (i=2Ee=2E why can't dm and loadpin =
share this instead of needing dm_verity_loadpin_set_trusted_digests()?)

>+
>+/*
>+ * Sets the root digests of verity devices which LoadPin considers as tr=
usted=2E
>+ *
>+ * This function must only be called once=2E
>+ */
>+void dm_verity_loadpin_set_trusted_root_digests(struct list_head *digest=
s)
>+{
>+	if (!trusted_root_digests)
>+		trusted_root_digests =3D digests;
>+	else
>+		pr_warn("verity root digests trusted by LoadPin are already set!!!\n")=
;
>+}
>+
>+static bool is_trusted_verity_target(struct dm_target *ti)
>+{
>+	u8 *root_digest;
>+	unsigned int digest_size;
>+	struct trusted_root_digest *trd;
>+	bool trusted =3D false;
>+
>+	if (!dm_is_verity_target(ti))
>+		return false;
>+
>+	if (dm_verity_get_root_digest(ti, &root_digest, &digest_size))
>+		return false;
>+
>+	list_for_each_entry(trd, trusted_root_digests, node) {
>+		if ((trd->len =3D=3D digest_size) &&
>+		    !memcmp(trd->data, root_digest, digest_size)) {
>+			trusted =3D true;
>+			break;
>+		}
>+	}
>+
>+	kfree(root_digest);
>+
>+	return trusted;
>+}
>+
>+/*
>+ * Determines whether a mapped device is a verity device that is trusted
>+ * by LoadPin=2E
>+ */
>+bool dm_verity_loadpin_is_md_trusted(struct mapped_device *md)
>+{
>+	int srcu_idx;
>+	struct dm_table *table;
>+	unsigned int num_targets;
>+	bool trusted =3D false;
>+	int i;
>+
>+	if (!trusted_root_digests || list_empty(trusted_root_digests))
>+		return false;
>+
>+	table =3D dm_get_live_table(md, &srcu_idx);
>+	num_targets =3D dm_table_get_num_targets(table);
>+	for (i =3D 0; i < num_targets; i++) {
>+		struct dm_target *ti =3D dm_table_get_target(table, i);
>+
>+		if (is_trusted_verity_target(ti)) {
>+			trusted =3D true;
>+			break;
>+		}
>+	}

Pardon my lack of dm vocabulary, but what is "target" vs "table" here? I w=
as only thinking of "whole device", so I must not understand what this is e=
xamining=2E

> [=2E=2E=2E]
>diff --git a/include/linux/dm-verity-loadpin=2Eh b/include/linux/dm-verit=
y-loadpin=2Eh
>new file mode 100644
>index 000000000000=2E=2E12a86911d05a
>--- /dev/null
>+++ b/include/linux/dm-verity-loadpin=2Eh
>@@ -0,0 +1,27 @@
>+/* SPDX-License-Identifier: GPL-2=2E0 */
>+
>+#ifndef __LINUX_DM_VERITY_LOADPIN_H
>+#define __LINUX_DM_VERITY_LOADPIN_H
>+
>+#include <linux/list=2Eh>
>+
>+struct mapped_device;
>+
>+struct trusted_root_digest {
>+	u8 *data;
>+	unsigned int len;
>+	struct list_head node;
>+};

To avoid the double-alloc in patch 2 (and save 1 pointer size of memory), =
this could just be:

struct trusted_root_digest {
	struct list_head node;
	unsigned int len;
	u8 data[];
};

Otherwise, looks good to me!

--=20
Kees Cook
