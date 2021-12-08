Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C557846D5DE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbhLHOlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhLHOlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:41:10 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ED1C061746;
        Wed,  8 Dec 2021 06:37:38 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id bn20so4175373ljb.8;
        Wed, 08 Dec 2021 06:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YQEKCLjlalppfIwA7C25NVMf1kXovJJ5rxk2lrnjyHg=;
        b=So2ZQ3i6muj1swwi9nVQYixhTs2rFja9AiQ6nJ9nLNUIVvFPji2T37cMyWIorjB8Cm
         2HpT3VAsnMAI8MqyDt/bzbrGGVvEPgYnznzoMIjXisy2rgL7LhukcLS+gjMTc5PLPjK2
         NzwMGX242y2VPjN8Ire2j6nsYdLo1b4Zi00Q3ulub8RG6MjGuARAm7CeXDUofBVzZr+M
         PvBTA4zf6RJye7X0Pgssf1FneIVFaGZxlqSPL0pHfM6Yau4A7z4BYBI4sZRD1/mYTMdi
         VBv+bE+3odK++P8GmCHqwKt500sx4N8ZGyFXykXUlrL2ZryYYVvyT9WViSfMgJ3EmR/N
         E4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YQEKCLjlalppfIwA7C25NVMf1kXovJJ5rxk2lrnjyHg=;
        b=vI5es/Qc5EfLcWuYdNIJW9oFpNK8euNNExwUNsEQlKS5OegEFnEUVsA5YFOV6gzNTo
         4/yn0t3PwVM31S5T6oikuga3je+nvjILryQTa2sgSQaJVYAO5D02lnL6B1TjsjgzhOp4
         41oax/doDjGfa0xf/JoStkney4RKhD4RwcxYc14TClVGFEmneHh2KXUR3UbcC89bFum0
         ErDMbgM8ZKwo1i3u9y9yNd4Gj9ucMzwScjPr18+USE8od6yHNDSR47yGmEThDzed4md7
         FVjO+ALN6/vqfOlCdlgqMnEfhjEPLWvJuAjwKQXTHads8nmURvD8C0/27rWdgprS30+Z
         +Vpw==
X-Gm-Message-State: AOAM533dH8HdRZNbj0lPlyyxQXnZD4JbaLB8wMc3cIf8V9Pa+YRttaLn
        rtxErYr+5OSX4QvmM31oaqlZhJrnp6I=
X-Google-Smtp-Source: ABdhPJyorDpZti4BMtPd9AOn+iX5gnjrZmrS7HTPOzlS2hL594mfM25Qm0jMuzeLpVYBk0sn/FQnPA==
X-Received: by 2002:a2e:8e38:: with SMTP id r24mr47966640ljk.450.1638974256178;
        Wed, 08 Dec 2021 06:37:36 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id z8sm270446lfu.128.2021.12.08.06.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 06:37:35 -0800 (PST)
Subject: Re: [PATCH v7 6/6] iommu/tegra-smmu: Add pagetable mappings to
 debugfs
To:     Nicolin Chen <nicolinc@nvidia.com>, thierry.reding@gmail.com,
        joro@8bytes.org, will@kernel.org
Cc:     vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20211208084732.23363-1-nicolinc@nvidia.com>
 <20211208084732.23363-7-nicolinc@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <085d4e6a-31b1-37c8-fe31-fb15119affc6@gmail.com>
Date:   Wed, 8 Dec 2021 17:37:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211208084732.23363-7-nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

08.12.2021 11:47, Nicolin Chen пишет:
> This patch dumps all active mapping entries from pagetable to a
> debugfs directory named "mappings".
> 
> Attaching an example:
> 
> [SWGROUP: xusb_host] [as: (id: 5), (attr: R|W|-), (pd_dma: 0x0000000080005000)]
> {
>         [index: 1023] 0xf0080040 (count: 52)
>         {
>                 PTE RANGE      | ATTR | PHYS               | IOVA               | SIZE
>                 [#913 , #913 ] | 0x7  | 0x0000000102674000 | 0x00000000fff91000 | 0x1000
>                 [#914 , #914 ] | 0x7  | 0x0000000102672000 | 0x00000000fff92000 | 0x1000
>                 [#915 , #915 ] | 0x7  | 0x0000000102671000 | 0x00000000fff93000 | 0x1000
>                 [#916 , #916 ] | 0x7  | 0x0000000102670000 | 0x00000000fff94000 | 0x1000
>                 [#921 , #921 ] | 0x7  | 0x00000000fcc00000 | 0x00000000fff99000 | 0x1000
>                 [#922 , #922 ] | 0x7  | 0x000000010266d000 | 0x00000000fff9a000 | 0x1000
>                 [#923 , #923 ] | 0x7  | 0x000000010266c000 | 0x00000000fff9b000 | 0x1000
>                 [#948 , #948 ] | 0x7  | 0x0000000102668000 | 0x00000000fffb4000 | 0x1000
>                 [#949 , #949 ] | 0x7  | 0x0000000102667000 | 0x00000000fffb5000 | 0x1000
>                 [#950 , #950 ] | 0x7  | 0x0000000102666000 | 0x00000000fffb6000 | 0x1000
>                 [#951 , #951 ] | 0x7  | 0x0000000102665000 | 0x00000000fffb7000 | 0x1000
>                 [#952 , #952 ] | 0x7  | 0x000000010264b000 | 0x00000000fffb8000 | 0x1000
>                 [#953 , #953 ] | 0x7  | 0x000000010264a000 | 0x00000000fffb9000 | 0x1000
>                 [#954 , #954 ] | 0x7  | 0x0000000102649000 | 0x00000000fffba000 | 0x1000
>                 [#955 , #955 ] | 0x7  | 0x0000000102648000 | 0x00000000fffbb000 | 0x1000
>                 [#956 , #956 ] | 0x7  | 0x000000010260f000 | 0x00000000fffbc000 | 0x1000
>                 [#957 , #957 ] | 0x7  | 0x000000010260e000 | 0x00000000fffbd000 | 0x1000
>                 [#958 , #958 ] | 0x7  | 0x000000010260d000 | 0x00000000fffbe000 | 0x1000
>                 [#959 , #959 ] | 0x7  | 0x000000010260b000 | 0x00000000fffbf000 | 0x1000
>                 [#960 , #992 ] | 0x7  | 0x00000001025ea000 | 0x00000000fffc0000 | 0x21000
>         }
> }
> Total PDEs: 1, total PTEs: 52

The patch is almost good to me, there is one nit.

On older SoCs we put multiple devices into the same shared group and the debugfs shows it as the first member of the group.

This is what we get on T30 using this v7:

# ls/sys/kernel/debug/smmu/mappings
g2  hc  vde

# cat /sys/kernel/debug/smmu/mappings/g2 
[SWGROUP: g2] [as: (id: 2), (attr: R|W|-), (pd_dma: 0x834a6000)]
{
        [index: 0] 0xf0083494 (count: 1000)
        {
                PTE RANGE      | ATTR | PHYS       | IOVA       | SIZE       
                [#0   , #15  ] | 0x7  | 0xbfde0000 | 0x00000000 | 0x10000    
                [#16  , #47  ] | 0x7  | 0xbfdc0000 | 0x00010000 | 0x20000    
                [#48  , #111 ] | 0x7  | 0xbfd80000 | 0x00030000 | 0x40000    
                [#112 , #239 ] | 0x7  | 0xbfd00000 | 0x00070000 | 0x80000    
                [#240 , #495 ] | 0x7  | 0xbfc00000 | 0x000f0000 | 0x100000   
                [#496 , #999 ] | 0x7  | 0xbf400000 | 0x001f0000 | 0x1f8000   
        }
}
Total PDEs: 1, total PTEs: 1000

See that name is "g2", meanwhile these mappings are made by display client driver.

I changed your patch to use the proper group name and to show all members of the group, see that change in the end of this email.

With my change applied, we get:

# ls/sys/kernel/debug/smmu/mappings
drm  hc  vde

# cat /sys/kernel/debug/smmu/mappings/drm 
[SWGROUP: dc, dcb, g2, nv, nv2] [as: (id: 2), (attr: R|W|-), (pd_dma: 0x82480000)]
{
        [index: 0] 0xf0083583 (count: 1000)
        {
                PTE RANGE      | ATTR | PHYS       | IOVA       | SIZE       
                [#0   , #15  ] | 0x7  | 0xbfde0000 | 0x00000000 | 0x10000    
                [#16  , #47  ] | 0x7  | 0xbfdc0000 | 0x00010000 | 0x20000    
                [#48  , #111 ] | 0x7  | 0xbfd80000 | 0x00030000 | 0x40000    
                [#112 , #239 ] | 0x7  | 0xbfd00000 | 0x00070000 | 0x80000    
                [#240 , #495 ] | 0x7  | 0xbfc00000 | 0x000f0000 | 0x100000   
                [#496 , #999 ] | 0x7  | 0xbf400000 | 0x001f0000 | 0x1f8000   
        }
}
Total PDEs: 1, total PTEs: 1000

--- >8 ---

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 575e82076270..fb1326a72038 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -509,6 +509,7 @@ static void tegra_smmu_as_unprepare(struct tegra_smmu *smmu,
 static int tegra_smmu_debugfs_mappings_show(struct seq_file *s, void *data)
 {
 	struct tegra_smmu_group *group = s->private;
+	const struct tegra_smmu_group_soc *soc;
 	const struct tegra_smmu_swgroup *swgrp;
 	struct tegra_smmu_as *as;
 	struct tegra_smmu *smmu;
@@ -524,6 +525,7 @@ static int tegra_smmu_debugfs_mappings_show(struct seq_file *s, void *data)
 
 	swgrp = group->swgrp;
 	smmu = group->smmu;
+	soc = group->soc;
 	as = group->as;
 
 	mutex_lock(&smmu->lock);
@@ -536,7 +538,38 @@ static int tegra_smmu_debugfs_mappings_show(struct seq_file *s, void *data)
 	if (!pd)
 		goto unlock;
 
-	seq_printf(s, "[SWGROUP: %s] ", swgrp->name);
+	seq_puts(s, "[SWGROUP: ");
+	if (soc) {
+		bool first_swgroup = true;
+		unsigned int i;
+
+		for (i = 0; i < soc->num_swgroups; i++) {
+			swgrp = tegra_smmu_find_swgrp(smmu, soc->swgroups[i]);
+
+			if (WARN_ON(!swgrp))
+				goto unlock;
+
+			val = smmu_readl(smmu, swgrp->reg);
+
+			if (!(val & SMMU_ASID_ENABLE))
+				continue;
+
+			if (WARN_ON((val & SMMU_ASID_MASK) != as->id))
+				continue;
+
+			if (first_swgroup)
+				first_swgroup = false;
+			else
+				seq_puts(s, ", ");
+
+			seq_printf(s, "%s", swgrp->name);
+		}
+	} else {
+		WARN_ON((val & SMMU_ASID_MASK) != as->id);
+		seq_printf(s, "%s", swgrp->name);
+	}
+	seq_puts(s, "] ");
+
 	seq_printf(s, "[as: (id: %d), ", as->id);
 	seq_printf(s, "(attr: %c|%c|%c), ",
 		   as->attr & SMMU_PD_READABLE ? 'R' : '-',
@@ -631,6 +664,7 @@ static void tegra_smmu_attach_as(struct tegra_smmu *smmu,
 {
 	const struct tegra_smmu_swgroup *swgrp;
 	struct tegra_smmu_group *group;
+	const char *name;
 
 	/* Find swgrp according to the swgroup id */
 	swgrp = tegra_smmu_find_swgrp(smmu, swgroup);
@@ -647,10 +681,16 @@ static void tegra_smmu_attach_as(struct tegra_smmu *smmu,
 				 "overwriting group->as for swgroup: %s\n", swgrp->name);
 		group->as = as;
 
-		if (smmu->debugfs_mappings)
-			debugfs_create_file(group->swgrp->name, 0444,
+		if (smmu->debugfs_mappings) {
+			if (group->soc)
+				name = group->soc->name;
+			else
+				name = group->swgrp->name;
+
+			debugfs_create_file(name, 0444,
 					    smmu->debugfs_mappings, group,
 					    &tegra_smmu_debugfs_mappings_fops);
+		}
 
 		break;
 	}
