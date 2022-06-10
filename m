Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC02B546B35
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 19:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243795AbiFJQ5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 12:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiFJQ5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:57:37 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F0310C3;
        Fri, 10 Jun 2022 09:57:31 -0700 (PDT)
X-UUID: 3074d9628a6c410286eeecd13f5fc3f3-20220611
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:a4bc0329-0515-494a-8883-0e46bb75846b,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:22,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:22
X-CID-INFO: VERSION:1.1.5,REQID:a4bc0329-0515-494a-8883-0e46bb75846b,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:22,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:22
X-CID-META: VersionHash:2a19b09,CLOUDID:e1dd5e50-276a-4a9a-a4c8-ea931023add4,C
        OID:IGNORED,Recheck:0,SF:28|100|17|19|48|101,TC:nil,Content:-5,EDM:-3,IP:n
        il,URL:0,File:nil,QS:0,BEC:nil
X-UUID: 3074d9628a6c410286eeecd13f5fc3f3-20220611
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 796968846; Sat, 11 Jun 2022 00:57:25 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Sat, 11 Jun 2022 00:57:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Sat, 11 Jun 2022 00:57:24 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <masahiroy@kernel.org>
CC:     <corbet@lwn.net>, <jonathanh@nvidia.com>,
        <linux-doc@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        <mpe@ellerman.id.au>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <penguin-kernel@I-love.SAKURA.ne.jp>,
        <trix@redhat.com>, <wangyugui@e16-tech.com>
Subject: Re: [PATCH v3] scripts/check-local-export: avoid 'wait $!' for process substitution
Date:   Sat, 11 Jun 2022 00:57:24 +0800
Message-ID: <20220610165724.16214-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220608011100.486735-1-masahiroy@kernel.org>
References: <20220608011100.486735-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Bash 4.4, released in 2016, supports 'wait $!' to check the exit status
>of a process substitution, but it seems too new.
>
>Some people using older bash versions (on CentOS 7, Ubuntu 16.04, etc.)
>reported an error like this:
>
>  ./scripts/check-local-export: line 54: wait: pid 17328 is not a child of this shell

Thanks for fixing this!
I hit this issue and this patch fixes my problem.

Tested-by: Miles Chen <miles.chen@mediatek.com> 

>
>I used the process substitution to avoid a pipeline, which executes each
>command in a subshell. If the while-loop is executed in the subshell
>context, variable changes within are lost after the subshell terminates.


