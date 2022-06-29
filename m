Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A7B55FC7E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiF2JxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbiF2JxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:53:11 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3181B2C1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:53:06 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id i64so14600707pfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KP3fUTyMybxgWttXPM/YRNz1NTtNbAM0PqEpXEZLz7c=;
        b=ntA7j9Cl/DWRky+1M/dkgSnk36GNGlzhY2GKWi1LRGfbKwwXWq+zu1HdLsfanp1a6x
         FHxTUbZBzP+PtS4V2EZrTOeBn2jUS4SX9s1w9HQFHiZqwLvzZg+WPs1A6VHw9bKqNXQx
         8Mp4kIFmfOwv8IxTeaz+ufoIv61CTt5r52dIfwAqdj5gJMSMrUGtKCg9QTOlfkFfM/Ye
         uXO1jA8w7RVFtuEDATSc4DKy2Wz3I6wjkDXiwfgxnFPJPz8QlofbWrkLkuHX7OjYaJTy
         oh5i+VMyMeoq1iOgGEtNmSqEvszJTMEG7ftA1sH7Tbz8zT3vpaKWIJjhTa959Fk7hkJ4
         U6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KP3fUTyMybxgWttXPM/YRNz1NTtNbAM0PqEpXEZLz7c=;
        b=1+ULQHDZCQEHBryDql2XYpGQnQryRhGsG6xqKohm5p7twDm3FzBevR1bHCquKEJjww
         hztfXmf4yhuyZg0GAJaCpvKHNUV2ubySl9j0LffDy/HuVDfjXcsD8jg6G5FOhtVUl3br
         igN78AAp8sCcnRd7j2QHgibuYBesdu8utaURt5Nyvf1/WW8ddhwFTC9+nBTO9Nd/UFLZ
         wMBENDQxYPXN8ZPzmR3OLoB1HgRf5+579wS0MRq2ZvJLyQgHDXcZ1Kgy3xG2HNpCPfrz
         nXMN+FxdpCDpz0gZRnBjxhOQKiO3gk5FXcvdlZLVLgkWwstpY5PC7Z6HqEZIDak55ZrM
         EjJg==
X-Gm-Message-State: AJIora/37/+z0oLjqo7pt/nDtqL0G+8t1GWqkkqBrxzCs7jumeZSEwAu
        /WVIcFa3t/dwSsMi42WfsMpqYA==
X-Google-Smtp-Source: AGRyM1trCTcCPBGGjudqgt9dfnfvoaMrWKGbiucA9M7RkpihgFrxiiiyoBP+0Cw4+jlVF4BRJmG0eg==
X-Received: by 2002:a63:6943:0:b0:40c:3020:d0b with SMTP id e64-20020a636943000000b0040c30200d0bmr2333956pgc.34.1656496385621;
        Wed, 29 Jun 2022 02:53:05 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id h24-20020a635318000000b0040dffa7e3d7sm5417918pgb.16.2022.06.29.02.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 02:53:05 -0700 (PDT)
Date:   Wed, 29 Jun 2022 15:23:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, rafael@kernel.org,
        dietmar.eggemann@arm.com, nm@ti.com, sboyd@kernel.org,
        sudeep.holla@arm.com, cristian.marussi@arm.com,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Energy Model power in micro-Watts and SCMI v3.1
 alignment
Message-ID: <20220629095302.bi3xx6yicsnjeff7@vireshk-i7>
References: <20220622145802.13032-1-lukasz.luba@arm.com>
 <be793e51-0d89-7afd-e122-ec929a1130e9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be793e51-0d89-7afd-e122-ec929a1130e9@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-06-22, 10:49, Lukasz Luba wrote:
> I would like to move forward with the micro-Watts in
> the Energy Model. We have feedback from our partners
> that this is a limitation. Also, as you can see
> this uW is part of the new SCMI spec, which we
> have support on our roadmap.

Should I pick them and merge via PM tree ?

-- 
viresh
