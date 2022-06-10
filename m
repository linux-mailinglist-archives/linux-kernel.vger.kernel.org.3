Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8403C546BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 19:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350148AbiFJRjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 13:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350086AbiFJRjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 13:39:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4F43B02E;
        Fri, 10 Jun 2022 10:39:02 -0700 (PDT)
X-UUID: fd0036f16f574af79af5206dbd1bf93a-20220611
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:9feb1afb-7c45-46c1-a7ee-393b09817e87,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:ba4c78e7-1f03-4449-90ad-e6cb8f3d1399,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:-5,EDM:-3,IP:nil,URL:0,File:ni
        l,QS:0,BEC:nil
X-UUID: fd0036f16f574af79af5206dbd1bf93a-20220611
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 233797589; Sat, 11 Jun 2022 01:38:56 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with ShadowRedundancy id 15.2.792.3;
 Fri, 10 Jun 2022 17:38:51 +0000
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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


