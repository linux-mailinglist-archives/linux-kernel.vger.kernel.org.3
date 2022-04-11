Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF89C4FB248
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 05:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244508AbiDKDY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 23:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240900AbiDKDY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 23:24:27 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78A219C38
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:22:14 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 2so13973390pjw.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZJz/3Tff3xT2pELYxTDnLdX/EaWMkTM/zNFqF30/VyA=;
        b=Mjc81Law1q/Ilavwb+/4Fl8wIGNrgvJ4XSMH+pz6jNcrc/pfNzRzOLeTYspW+81oS/
         77z0QvGT//6FsfY4Ct2Y5sBYndVVzd2Iqw5DKAQzYjwbq7eDJKOLcqSGbNwaHlWNOzsY
         1eAgs8pw2bwHNVYsy04xXp97MRPBlkFRcigXrOj3VirS0xe/u2WHB0gjMjUA8AAdcX1Z
         c2V3itDAt6+pi5L1IMUcDTXLq6GTjlaU8YxQqqLeXjQx36VtZacCtHgGhRKVlmdSCzWt
         5i498X+ImMLXo5nzun2iLybfce7AHARAsjKQTtepnmQG9W1j2KQmgq56Ay6jLXQOrkPt
         nRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZJz/3Tff3xT2pELYxTDnLdX/EaWMkTM/zNFqF30/VyA=;
        b=vsb/mAGDnwiqCFw7pGT8xUNX5Nidytq4XNHfgDlWTeIzKUWODQ3fFkr3U3urenqAW4
         IjYsda+LUfpwxSnIdVQVYWbXHf2Yg3TXLnkehZsLl+LHt020CyAol1D616biPXjCBcZj
         zsMit1SjfeqqC5z1rjg7jRiFzROxCBg1J627qC08TdplL+p6249LsRT/5dITewU8qZdJ
         QrkTggmAjrnLhrgvFqqRdVAwFJOM7IAB2kwZxt0fBrKajtSXz4TW8ISzmZXkmzQqm/oc
         J8WbbZUPlUWCVKc5CHa4DlDHmMWZFVCtzvT9oAMaSZvhIiZxleqDAlE2Ma3brkmfgGvp
         s1dQ==
X-Gm-Message-State: AOAM53180Mm+Dv2orfN7h7vQAs6ZhTmp+hjadMZ8IiRATdthG9v0zBXh
        Atc2BKMpFTrTEPyKOV73KjBrRg==
X-Google-Smtp-Source: ABdhPJxkTNwLJIMc6qRweDVyjvM5N0omwM+B7eZrYk7M8BHCNbM5RZeL+7W7H7udDcNR2U7WziPuTQ==
X-Received: by 2002:a17:903:2309:b0:153:ad3f:b074 with SMTP id d9-20020a170903230900b00153ad3fb074mr29764882plh.82.1649647334268;
        Sun, 10 Apr 2022 20:22:14 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id h10-20020a056a00230a00b004faa0f67c3esm32288549pfh.23.2022.04.10.20.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 20:22:13 -0700 (PDT)
Date:   Mon, 11 Apr 2022 08:52:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com,
        jia-wei.chang@mediatek.com, roger.lu@mediatek.com,
        hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Andrew-sh . Cheng" <andrew-sh.cheng@mediatek.com>
Subject: Re: [PATCH V2 05/15] cpufreq: mediatek: Enable clocks and regulators
Message-ID: <20220411032212.q46sqavjpvj6vsyy@vireshk-i7>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
 <20220408045908.21671-6-rex-bc.chen@mediatek.com>
 <bcc8a0e1-144e-b9ba-9532-f54d4051d8a6@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcc8a0e1-144e-b9ba-9532-f54d4051d8a6@collabora.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-04-22, 15:36, AngeloGioacchino Del Regno wrote:
> Il 08/04/22 06:58, Rex-BC Chen ha scritto:
> > From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > 
> > We need to enable regulators so that the max and min requested values will
> > be recorded.
> > The intermediate clock is not always enabled by CCF in different projects,
> > so we should enable it in the cpufreq driver.
> > 
> > Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied. Thanks.

-- 
viresh
