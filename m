Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5769528D77
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345153AbiEPSwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345141AbiEPSv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:51:57 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED023EAA2
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:51:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id v11so14835351pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w/vXrhHYz4hayxXTpvluCRqtSLwMXWsi89GFr9tS/YQ=;
        b=JRehcpW7+f4z4nnJVoYyyn8JTHfm9l7lwwg3/Zc+NghG/A9LUfElMU7tlAgI6zJnGo
         LKCQmvcigbZB1ml+BnZ81ev55Yy/YSw6DMFKbYvOep7hxWh/H/lxwexytzZbDoi5s68a
         gMMP2W5FrOB7qNl/5JgcTVgbYZxRV0HozsCvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w/vXrhHYz4hayxXTpvluCRqtSLwMXWsi89GFr9tS/YQ=;
        b=BmTlZeF7pkFaXS/Wp3WzS5l5Z1KbzXxkczF6j/+HZ6vk9lJq6eAPZKGrZkfGqVnpaj
         ZZAcigv02SAvkJc0FhcWbaRi/x5Rh5Brix5SVSChWZi4fS2/ZPORtk21tFNOSynAhB3L
         IGSBQppDFhJGnWUZs66sS5GoQ4pfFMM0Fi4SesyqmcbQ4j8gd4Bn3UvPvQ3e/52FU0GZ
         VoF4Gu5ACiPo0PbUutOdjHgR0Z2Fp0mSR8cUnNEeNZGVmomP1QxLF8ff3KCFsW6Ui3k1
         6/cp7VVfxebQlcMIFCBXIeNUz45mdVyaHl7FgrZrfMgiaxvex34bnBn7/MWymRT9Ug/O
         p9uA==
X-Gm-Message-State: AOAM530hOkgmF5hPURNyANPiO/reSZk9vGYC0IlnOOiTyTf1svScfU60
        2ccwDTvjzPHyocrtrCF9iOPdRQ==
X-Google-Smtp-Source: ABdhPJymcURqRMGcWWF5SnA9wwUQk3JoOR0K/mUC0Yv15khQOmO0SNCL+Q4Njsx+FkSULBV01/EO0w==
X-Received: by 2002:a63:4387:0:b0:3c6:9490:4e4b with SMTP id q129-20020a634387000000b003c694904e4bmr16157541pga.438.1652727116092;
        Mon, 16 May 2022 11:51:56 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:4ee0:ca4c:63fd:81d2])
        by smtp.gmail.com with UTF8SMTPSA id b2-20020a170902650200b0015e8d4eb264sm7480975plk.174.2022.05.16.11.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 11:51:55 -0700 (PDT)
Date:   Mon, 16 May 2022 11:51:54 -0700
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
Subject: Re: [PATCH v3 1/3] dm: Add verity helpers for LoadPin
Message-ID: <YoKdSrjVf/tHGoa5@google.com>
References: <20220504195419.1143099-1-mka@chromium.org>
 <20220504125404.v3.1.I3e928575a23481121e73286874c4c2bdb403355d@changeid>
 <02028CEA-5704-4A51-8CAD-BEE53CEF7CCA@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02028CEA-5704-4A51-8CAD-BEE53CEF7CCA@chromium.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 03:15:53PM -0700, Kees Cook wrote:
> 
> 
> On May 4, 2022 12:54:17 PM PDT, Matthias Kaehlcke <mka@chromium.org> wrote:
> >LoadPin limits loading of kernel modules, firmware and certain
> >other files to a 'pinned' file system (typically a read-only
> >rootfs). To provide more flexibility LoadPin is being extended
> >to also allow loading these files from trusted dm-verity
> >devices. For that purpose LoadPin can be provided with a list
> >of verity root digests that it should consider as trusted.
> >
> >Add a bunch of helpers to allow LoadPin to check whether a DM
> >device is a trusted verity device. The new functions broadly
> >fall in two categories: those that need access to verity
> >internals (like the root digest), and the 'glue' between
> >LoadPin and verity. The new file dm-verity-loadpin.c contains
> >the glue functions.
> >
> >Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > [...]
> >diff --git a/drivers/md/dm-verity-loadpin.c b/drivers/md/dm-verity-loadpin.c
> >new file mode 100644
> >index 000000000000..972ca93a2231
> >--- /dev/null
> >+++ b/drivers/md/dm-verity-loadpin.c
> >@@ -0,0 +1,80 @@
> >+// SPDX-License-Identifier: GPL-2.0-only
> >+
> >+#include <linux/list.h>
> >+#include <linux/kernel.h>
> >+#include <linux/dm-verity-loadpin.h>
> >+
> >+#include "dm.h"
> >+#include "dm-verity.h"
> >+
> >+static struct list_head *trusted_root_digests;
> 
> Does this need to exist in two places? (i.e. why can't dm and loadpin share
> this instead of needing dm_verity_loadpin_set_trusted_digests()?)

We could share it. Probably it should then be defined here, since this is
the first patch of the series, we could add an extern declaration to
dm-verity-loadpin.h.

> >+
> >+/*
> >+ * Sets the root digests of verity devices which LoadPin considers as trusted.
> >+ *
> >+ * This function must only be called once.
> >+ */
> >+void dm_verity_loadpin_set_trusted_root_digests(struct list_head *digests)
> >+{
> >+	if (!trusted_root_digests)
> >+		trusted_root_digests = digests;
> >+	else
> >+		pr_warn("verity root digests trusted by LoadPin are already set!!!\n");
> >+}
> >+
> >+static bool is_trusted_verity_target(struct dm_target *ti)
> >+{
> >+	u8 *root_digest;
> >+	unsigned int digest_size;
> >+	struct trusted_root_digest *trd;
> >+	bool trusted = false;
> >+
> >+	if (!dm_is_verity_target(ti))
> >+		return false;
> >+
> >+	if (dm_verity_get_root_digest(ti, &root_digest, &digest_size))
> >+		return false;
> >+
> >+	list_for_each_entry(trd, trusted_root_digests, node) {
> >+		if ((trd->len == digest_size) &&
> >+		    !memcmp(trd->data, root_digest, digest_size)) {
> >+			trusted = true;
> >+			break;
> >+		}
> >+	}
> >+
> >+	kfree(root_digest);
> >+
> >+	return trusted;
> >+}
> >+
> >+/*
> >+ * Determines whether a mapped device is a verity device that is trusted
> >+ * by LoadPin.
> >+ */
> >+bool dm_verity_loadpin_is_md_trusted(struct mapped_device *md)
> >+{
> >+	int srcu_idx;
> >+	struct dm_table *table;
> >+	unsigned int num_targets;
> >+	bool trusted = false;
> >+	int i;
> >+
> >+	if (!trusted_root_digests || list_empty(trusted_root_digests))
> >+		return false;
> >+
> >+	table = dm_get_live_table(md, &srcu_idx);
> >+	num_targets = dm_table_get_num_targets(table);
> >+	for (i = 0; i < num_targets; i++) {
> >+		struct dm_target *ti = dm_table_get_target(table, i);
> >+
> >+		if (is_trusted_verity_target(ti)) {
> >+			trusted = true;
> >+			break;
> >+		}
> >+	}
> 
> Pardon my lack of dm vocabulary, but what is "target" vs "table" here?
> I was only thinking of "whole device", so I must not understand what this is
> examining.

'targets' are different types of DM mappings like 'linear' or 'verity'. A
device mapper table contains has one or more targets that define the mapping
of the blocks of the mapped device.

Having spelled that out I realize that the above check is wrong. It would
consider a device like this trusted:

0 10000000 linear 8:1
10000000 10001000 verity <params>

In the above case only a small part of the DM device would be backed by verity.

I think we want a table with a single entry that is a verity target.

> > [...]
> >diff --git a/include/linux/dm-verity-loadpin.h b/include/linux/dm-verity-loadpin.h
> >new file mode 100644
> >index 000000000000..12a86911d05a
> >--- /dev/null
> >+++ b/include/linux/dm-verity-loadpin.h
> >@@ -0,0 +1,27 @@
> >+/* SPDX-License-Identifier: GPL-2.0 */
> >+
> >+#ifndef __LINUX_DM_VERITY_LOADPIN_H
> >+#define __LINUX_DM_VERITY_LOADPIN_H
> >+
> >+#include <linux/list.h>
> >+
> >+struct mapped_device;
> >+
> >+struct trusted_root_digest {
> >+	u8 *data;
> >+	unsigned int len;
> >+	struct list_head node;
> >+};
> 
> To avoid the double-alloc in patch 2 (and save 1 pointer size of memory), this could just be:
> 
> struct trusted_root_digest {
> 	struct list_head node;
> 	unsigned int len;
> 	u8 data[];
> };

Looks good to me, will change

> Otherwise, looks good to me!

Excellent, thanks for the review!
