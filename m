Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1E94D0EB7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 05:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245068AbiCHEhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 23:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237826AbiCHEhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 23:37:13 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500822B254
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 20:36:18 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id s18so2755826plp.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 20:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hhcpglpMzPp1zRw4giaVrf5u6Sl21ZWC49Bq67Qrzfg=;
        b=Xc9jz6kvXfky7WDyu63HYTIf0sTMeTSiOMenwRCh6w8DSspn8BDfIIcmZaWcu+9P4g
         zSZAEMIDZTGQPMcpUr8WkVB9AELF9BX54DXYzHjW3ZFDDwLTQArf7TLhBOpqetpEN/dd
         ehFwyHshOb3wt3cMeSUu/bWqZy9Kgb4JRXDW0AT66LkHetwiUDHfksyuwXsvf4vGvrIL
         gpDl2I93YDAWfOwO09bZAmV+yvP9aol9Kp+UcJucLnrYG+NRkKHQCf52n1nwzrEh2wyD
         w6YsnNR733Ci7CRfcUY8mZYvPawQaq0uIM9+EOY6R1Qi+xU/kTEgcz6ob2qJL9OdeIET
         V+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hhcpglpMzPp1zRw4giaVrf5u6Sl21ZWC49Bq67Qrzfg=;
        b=wIDgFzrT2Gc03AK28+VC3mWmnlN8JMZo00xr898iYFlPfAm3V99Z0VdLYpgeKGTrUB
         sQz83GQhU0RjblTFrDBsUdaloVckhttpzCSU5YXDEZ9WgcIvLH8W803Uz6O0lsKkfL+Z
         0slJZRvou8qc+W2xeiLXwrcesTG2fIqcC1kHlqv/F90nFqvsrzWklfje6i8zEoNhge0J
         2vPEygSI+NMiq7pqQtPRdrKmhh1PNq1gLGAR7hCov2GPqgQIDUoA8dAMxhjWguetJ4s7
         Ix34iLmcEqtgWbtzye8hfprbNq+859G438Iiu8gLVdjbPdMZ/Dt4aweuHc4H5SNQXcLv
         vXOQ==
X-Gm-Message-State: AOAM532ZnJ/gNdw3xhRNQaK2095c1UtqxfMQ9NewgSWJ2eVGM0+ep9Ac
        OcNilqhEMfL9WDdW1wNixGLUkA==
X-Google-Smtp-Source: ABdhPJyeLmQ0tzc/aEf5lGsbCCAeOa4K+3koVTtM3WL8KO85y8vgAkdbWzoa3spHjolLf1DnsTFyyQ==
X-Received: by 2002:a17:902:ab52:b0:14d:7ce1:8d66 with SMTP id ij18-20020a170902ab5200b0014d7ce18d66mr15807860plb.88.1646714177838;
        Mon, 07 Mar 2022 20:36:17 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id q20-20020a056a00151400b004f3cd061d33sm17996768pfu.204.2022.03.07.20.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 20:36:17 -0800 (PST)
Date:   Tue, 8 Mar 2022 10:06:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Tim Chang <jia-wei.chang@mediatek.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fan.chen@mediatek.com,
        louis.yu@mediatek.com, roger.lu@mediatek.com,
        Allen-yy.Lin@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com
Subject: Re: [PATCH 0/4] cpufreq: mediatek: introduce mtk cpufreq
Message-ID: <20220308043615.uamxqylo3mvw4rhs@vireshk-i7>
References: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
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

On 07-03-22, 20:21, Tim Chang wrote:
> CPUFREQ is DVFS driver used for power saving by scaling clock frequency
> and supply voltage of CPUs. This module cooperates with CCI DEVFREQ for
> certain Mediatek SoCs.

Both subject and this log talks as if you are adding a new cpufreq
driver, while what you are doing is just cleanup mostly. This isn't
how it should be done.

You need to be very explicit with what you are doing and make that
change in a separate patch. The cover letter should tell what you are
doing and why.

-- 
viresh
