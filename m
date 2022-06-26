Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2AE55AE79
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 05:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiFZD2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 23:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbiFZD2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 23:28:33 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DC21147C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 20:28:30 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id bd16so8642327oib.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 20:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RqOSrVav6dU2nmRFVG/BMhdhMSZeEt0YoIOWTqo4LME=;
        b=z8nHIm7hfTZjmF+GyKjb5qIaDqyBCc5A3ktrVAsyewCbQW0C7pFns4zRluMgHKcsm4
         Y3uHHVsJafCt9Rzyto3Ddns1pAOe72z5jn6XwJ8Nyrv6aOGZI+7PzzkMuZnJ1mKJGV1+
         stczT3ZQeTkbD+n5Fac39JuvInaOEQBFUZv1+b3kI5URwgAj1J188zfhIj+lx4S7AnLl
         VRPfwpTU0AyDokK7yQIqMUcQ5DXx92JKYW79XYJjjj8yF9TukI1KO/EZSbC5W7mU7Hcm
         5jpTGnsom8IvRT/L5ELl/DxinIuTMi8uRorP2sloPBVsBt1z4sJN05jQjgoLCv33pmxf
         z/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RqOSrVav6dU2nmRFVG/BMhdhMSZeEt0YoIOWTqo4LME=;
        b=kt/+SsF4CI3nMRatceE6Kpmt2MR+7RiNcW+GGYqhx0tQ1HdkjedextBHBLWrW4uxBy
         uyKCTuHnNkrxxlu4ZXZN0sYLnI/o2ZzC6BgQRedLCQYQd35cp0tfuURlVGUTuczxfdQo
         Yu/S/s6hlazoi5tfMJkCLnN/vu8KdRnbSeR37I7Yka8yGROLuHDaq9t23QsMB+J5ep33
         O0XDKgRXae3HIBplfRUOxRfuyEeU+yCmNTvYBT9O+WTziuembPMQUNbxe+3EowVao7US
         efB/rhRCXTDOjl6tHmrlIfYXmbk6acskgYyf8JjK7ae53XUF6VIFmwilNDMuJo4wsHH4
         Bkbw==
X-Gm-Message-State: AJIora/jqb20FBwkREwzyFkb6qp+ZMf000I3ap3z/GDvFj5HhyOgo2Hn
        tVa8CS6I4DJiqp/PLjLHJnmPoA==
X-Google-Smtp-Source: AGRyM1tx8+6+Zu+4IZgFzgGg5Ks/WomGiGglgk8urzN6S7v9axXx6pFjUKoTIgXW9WArCc36O0/sSw==
X-Received: by 2002:aca:bfc6:0:b0:32e:b45d:bd72 with SMTP id p189-20020acabfc6000000b0032eb45dbd72mr7083019oif.274.1656214109737;
        Sat, 25 Jun 2022 20:28:29 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id i13-20020a056808054d00b0032ed4543c36sm3456972oig.36.2022.06.25.20.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 20:28:29 -0700 (PDT)
Date:   Sat, 25 Jun 2022 22:28:27 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [PATCH v4 4/4] arm64: dts: qcom: sdm845: Add CPU BWMON
Message-ID: <YrfSWw9Wpq5TsRUt@builder.lan>
References: <20220601101140.170504-1-krzysztof.kozlowski@linaro.org>
 <20220601101140.170504-5-krzysztof.kozlowski@linaro.org>
 <bc423d7b-df03-d4e2-2898-0873db710943@quicinc.com>
 <64eb52ee-b3ac-3d94-cfce-ceb1c88dddb6@linaro.org>
 <042cb765-113b-9335-edae-595addf50dd0@quicinc.com>
 <23320e3c-40c3-12bb-0a1c-7e659a1961f2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23320e3c-40c3-12bb-0a1c-7e659a1961f2@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23 Jun 07:58 CDT 2022, Krzysztof Kozlowski wrote:

> On 23/06/2022 08:48, Rajendra Nayak wrote:
> >>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >>>> index 83e8b63f0910..adffb9c70566 100644
> >>>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >>>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >>>> @@ -2026,6 +2026,60 @@ llcc: system-cache-controller@1100000 {
> >>>>    			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
> >>>>    		};
> >>>>    
> >>>> +		pmu@1436400 {
> >>>> +			compatible = "qcom,sdm845-cpu-bwmon";
> >>>> +			reg = <0 0x01436400 0 0x600>;
> >>>> +
> >>>> +			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
> >>>> +
> >>>> +			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
> >>>> +					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> >>>> +			interconnect-names = "ddr", "l3c";
> >>>
> >>> Is this the pmu/bwmon instance between the cpu and caches or the one between the caches and DDR?
> >>
> >> To my understanding this is the one between CPU and caches.
> > 
> > Ok, but then because the OPP table lists the DDR bw first and Cache bw second, isn't the driver
> > ending up comparing the bw values thrown by the pmu against the DDR bw instead of the Cache BW?
> 
> I double checked now and you're right.
> 
> > Atleast with my testing on sc7280 I found this to mess things up and I always was ending up at
> > higher OPPs even while the system was completely idle. Comparing the values against the Cache bw
> > fixed it.(sc7280 also has a bwmon4 instance between the cpu and caches and a bwmon5 between the cache
> > and DDR)
> 
> In my case it exposes different issue - under performance. Somehow the
> bwmon does not report bandwidth high enough to vote for high bandwidth.
> 
> After removing the DDR interconnect and bandwidth OPP values I have for:
> sysbench --threads=8 --time=60 --memory-total-size=20T --test=memory
> --memory-block-size=4M run
> 
> 1. Vanilla: 29768 MB/s
> 2. Vanilla without CPU votes: 8728 MB/s
> 3. Previous bwmon (voting too high): 32007 MB/s
> 4. Fixed bwmon 24911 MB/s
> Bwmon does not vote for maximum L3 speed:
> bwmon report 9408 MB/s (thresholds set: <9216000 15052801>
> )
> osm l3 aggregate 14355 MBps -> 897 MHz, level 7, bw 14355 MBps
> 
> Maybe that's just problem with missing governor which would vote for
> bandwidth rounding up or anticipating higher needs.
> 
> >>> Depending on which one it is, shouldn;t we just be scaling either one and not both the interconnect paths?
> >>
> >> The interconnects are the same as ones used for CPU nodes, therefore if
> >> we want to scale both when scaling CPU, then we also want to scale both
> >> when seeing traffic between CPU and cache.
> > 
> > Well, they were both associated with the CPU node because with no other input to decide on _when_
> > to scale the caches and DDR, we just put a mapping table which simply mapped a CPU freq to a L3 _and_
> > DDR freq. So with just one input (CPU freq) we decided on what should be both the L3 freq and DDR freq.
> > 
> > Now with 2 pmu's, we have 2 inputs, so we can individually scale the L3 based on the cache PMU
> > counters and DDR based on the DDR PMU counters, no?
> > 
> > Since you said you have plans to add the other pmu support as well (bwmon5 between the cache and DDR)
> > how else would you have the OPP table associated with that pmu instance? Would you again have both the
> > L3 and DDR scale based on the inputs from that bwmon too?
> 
> Good point, thanks for sharing. I think you're right. I'll keep only the
> l3c interconnect path.
> 

If I understand correctly, <&osm_l3 MASTER_OSM_L3_APPS &osm_l3
SLAVE_OSM_L3> relates to the L3 cache speed, which sits inside the CPU
subsystem. As such traffic hitting this cache will not show up in either
bwmon instance.

The path <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>
affects the DDR frequency. So the traffic measured by the cpu-bwmon
would be the CPU subsystems traffic that missed the L1/L2/L3 caches and
hits the memory bus towards DDR.


If this is the case it seems to make sense to keep the L3 scaling in the
opp-tables for the CPU and make bwmon only scale the DDR path. What do
you think?

Regards,
Bjorn
