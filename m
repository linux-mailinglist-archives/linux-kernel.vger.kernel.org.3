Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0B55A509D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiH2PtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiH2Pss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:48:48 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7B095ADC
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:48:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r4so10678645edi.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=mHpjYI6QcaCSHOvbWt8Moq9oJMF1GJnVWRiLawfEmvo=;
        b=fSfztW46mx7xfnjr/sbNt5AUq47NnMbc350DFDBjC7UfwCT6yMIUbi3yADdtDc0WDZ
         +Ajn3EHfMJPZBSXH298Ab4y37Rh2GwUavapdnkTTite7EVYwHwXcORB8ldJ6DPdnWw99
         IjpRJr/FkkU9nsG4jtHjEx6o0X0XyYKfjOs6q4b3QGsYl2Ru7o6HRgphEDb1hJPxFdn7
         AHUh09YkdXOWOED6AuEFlqml4qdBnufqUaT3TjuTF1TVwcfxQPj1youLg+gySRB2U/2I
         LgMR398ZPcYVbTplWviuxQMqiA4NA9KqbO4ZnVWeCJ3eljiC6jiI+eZf+0Q4u3pMypqE
         5EZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=mHpjYI6QcaCSHOvbWt8Moq9oJMF1GJnVWRiLawfEmvo=;
        b=W7aNZOiRwPDILPG36XRgs0inUagK0G8nTWRnE6hGRHTmrkxdomkeVSdK+fCAimhAc7
         yByxpbx1h7UfDLbTBtdpyqAjITMC+MF4le6jWjbPiVrF5x4z1gjBPOT8Ix/G+eRXiWtj
         +YdD//UqrTAm5jK274q/RMzOyBVNhl1xIjPaBxRRpicF5D/E2cJMXkLzufwPRivYiAtt
         CHuRvN3ARklmcA1twmkuWwc52cwiaxFiI5GEIq0Dwu8/3I2Y/vSdsWnNyolQCEqbouu/
         zo+9KUf2s94vd8XxHG4gJRlxQ21h0WMu/Bhrt/SZFFk2PWu94a1M9s5drSgMIr5xQIPs
         3Bng==
X-Gm-Message-State: ACgBeo3M+XcbXQTWXBQ+36iXfh46RA6/Iaium+6YVDw5x9aIwtqEKuN1
        1Eiy20OTUPMI+DK0/57X1e4NmA==
X-Google-Smtp-Source: AA6agR722GIJV6NOompv1BqGkAy1eLk7wqlzKoIk5XqcAbc0U9DZJK1dL3XP1xuYogSMM+O5vTORAQ==
X-Received: by 2002:a05:6402:1f06:b0:447:f6a0:2f71 with SMTP id b6-20020a0564021f0600b00447f6a02f71mr11933223edb.243.1661788120784;
        Mon, 29 Aug 2022 08:48:40 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id p17-20020a056402501100b004481af6c760sm4276132eda.0.2022.08.29.08.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 08:48:40 -0700 (PDT)
Date:   Mon, 29 Aug 2022 15:48:37 +0000
From:   Quentin Perret <qperret@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Jian-Min <Jian-Min.Liu@mediatek.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] sched/pelt: Introduce PELT multiplier
Message-ID: <Ywzf1axLAnLIqRP0@google.com>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <20220829055450.1703092-2-dietmar.eggemann@arm.com>
 <Ywxz7cuR+/+1CFMR@hirez.programming.kicks-ass.net>
 <YwyOzgbbUbB+JmSH@hirez.programming.kicks-ass.net>
 <CAKfTPtAnC4escfufhjJkqsYyhDPzpmQH4xYT4nj=EjCP7gzifg@mail.gmail.com>
 <YwzL1eJUIReAEv0l@google.com>
 <YwzOf5WV5G8dQBGb@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwzOf5WV5G8dQBGb@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-14.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 Aug 2022 at 16:34:39 (+0200), Peter Zijlstra wrote:
> On Mon, Aug 29, 2022 at 02:23:17PM +0000, Quentin Perret wrote:
> 
> > I'll let folks in CC comment about their use-case in more details, but
> > there's definitely been an interest in tuning this thing at run-time
> 
> An interest and it making sense are two very distinct things that bear
> no relation to one another in any way.

And just to clarify something here as my first message was misleading,
the run-time tuning of PELT HLs has been used in some Android products
for a little while already, so it's more than just a mere 'interest'.

That doesn't close the debate on whether this makes any sense, but I
figured this should be mentioned :-)
