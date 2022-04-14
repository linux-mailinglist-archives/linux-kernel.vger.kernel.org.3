Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859EA501E18
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344078AbiDNWK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244107AbiDNWK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:10:27 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F96ADD61;
        Thu, 14 Apr 2022 15:07:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id g18so12500792ejc.10;
        Thu, 14 Apr 2022 15:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=a+eBKXg+HvEOWqCYxJUK4jczCUZDQAIkE1tarFAa5PQ=;
        b=POyZeHcWT1no5HjX1bNC8NvYTtOBHqFwIiC+OxkhZfXmSoyfEEq+yGr0w5GRkl+4M/
         cjAAzAbPkdKCUd78AbBDRBDKBws7momKROy6V13z74cZZ4HRfvaD9AlFYAb4NH7wb4s2
         9c8e/PSlXRnWz4MarGy5iIwMz3v0Zn+L9ink5i61suX7E0ZKfO6W6HE0BGdJiPhPmT6r
         EkFE89fAEraKstWMgYy+T6ExJmM6O060n37UVUIKhV2ML3EDO7peh0Ffv8lwu/+SA7xs
         6Dzq2ZyUNb7MOEzm8AFCqNGcLaBVxPjFDblAeDmrURkxTSEXf7TfzLX5LXh3OXv3IrQG
         uZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=a+eBKXg+HvEOWqCYxJUK4jczCUZDQAIkE1tarFAa5PQ=;
        b=Kiam+A5lmabEQgKDtobqcz+vJiMSbZfhVL1fJLZRA6IBE4fAeKnAiIldQ+yDBoGcb5
         NIQlFW2ByxfBFTERKG6fm88OKFsJb/QNtYx592WuOzqQhFkhAefr/9Jcf3o4snIdZgXC
         tCjnND5XTf59jv+4viiz/PVfdB1AiluO2a54Ielh3FuJATbP7EqHMnD0qNvxXWe+/wqx
         EEREW17MLD8cLCQFv0uRpPQifPUGplNpIxgcLcLBsPxBHxRWAKBfidnzBZgxg4veHL/r
         G/ljB+vlxItIBpQDnKlG2t5rOAtiH17323gApxv0CZ0UHSvv7HlQP6uTwmtAd0pKcil9
         12hQ==
X-Gm-Message-State: AOAM530uqPUJIxvrvV3jK1fdUOg1NKBVNVFGo3DXzGhy2TD8koL2Ib5d
        s+l1DTJjyQMziiAUy2MdQ9c=
X-Google-Smtp-Source: ABdhPJycg5sAyJlqC0y3pBXqqj2ZKaEeWREZOLjoq30ZvH+3SM9+ZvZB3WG6oizUmc1EycU86vYKXg==
X-Received: by 2002:a17:906:65d5:b0:6ba:3133:dfb9 with SMTP id z21-20020a17090665d500b006ba3133dfb9mr4135427ejn.56.1649974077944;
        Thu, 14 Apr 2022 15:07:57 -0700 (PDT)
Received: from [192.168.3.2] (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.googlemail.com with ESMTPSA id k15-20020a50ce4f000000b00420119333c1sm1687605edj.62.2022.04.14.15.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 15:07:57 -0700 (PDT)
Message-ID: <44108a7ad56dd6984523af35cfa003f4ed7be41e.camel@gmail.com>
Subject: Re: [PATCH 1/1] scsi: ufs: remove redundant HPB unmap
From:   Bean Huo <huobean@gmail.com>
To:     Po-Wen Kao <powen.kao@mediatek.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        chun-hung.wu@mediatek.com, cc.chou@mediatek.com,
        chaotian.jing@mediatek.com, jiajie.hao@mediatek.com,
        yohan.joung@sk.com, jason.li@sk.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Date:   Fri, 15 Apr 2022 00:07:56 +0200
In-Reply-To: <004b55d8-fcd3-136c-526c-6ada025d6a1c@mediatek.com>
References: <20220412073131.10644-1-powen.kao@mediatek.com>
         <781bfe33efb1e44d22f71e6711da7d15be9d3ab4.camel@gmail.com>
         <7550da4043ae45ffd58399f1ee696238a5689f25.camel@gmail.com>
         <004b55d8-fcd3-136c-526c-6ada025d6a1c@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-04-14 at 12:49 +0800, Po-Wen Kao wrote:
> Hi Bean,
>=20
> The general idea looks good.
>=20
> As ufshpb_issue_umap_all_req in ufshpb_state_toggle won't actually
> runs=20
> at cold boot probe due to the fact that sdev are not present yet,
> this=20
> should avoid sending HPB command before UAC being cleared while keeps
> HPB mapping clean when rest flow occurs.
>=20
> Just a concern, shouldn't ufshpb_issue_umap_all_req be send for each=20
> sdev's corresponding hpb?
>=20

Hi Po Wen,

I replied in another email that setting the flag resets all active
regions in the device, which is a more efficient way, I have submitted
a fix for HPB device mode, your review and testing are welcome.

Kind regards,
Bean

> Looking forward to your further fixes.
>=20
>=20

