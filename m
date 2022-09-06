Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713A15AF801
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 00:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiIFWcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 18:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiIFWcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 18:32:04 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505988A7D7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 15:32:03 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id u5so5074958qvv.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 15:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Mtcu5af70evTT3fbOV+V5zfVRDwyrQCko52sY5cVhcg=;
        b=MUKUNeSzKJdsN3Qb5nS1G483fq8T2gOozXD2zdbdk3Bcl8juL7DedSlztqB/fS3WOr
         PKGORSNOiC2CbmrQpSQj1L8+HWnEJUeRPV3zyPwlUmczmpnzRciLBJhs22DxJzIo51GY
         aiy8qQEire1kRnPm1A3+Zknfdtv7QB/xD99tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Mtcu5af70evTT3fbOV+V5zfVRDwyrQCko52sY5cVhcg=;
        b=OWVSmrMrziGb/QeqAwPVxXIrNMlPHBdDlSjNm9tkeCj7/+5GEGUNJ/79NXNgGo92xs
         b0jz/rROV7rNkrKtj7/jWM/rnsnYeqqmRwXxlQ7lkKB4bf0eV7f+a2kbi6tBzYXzYwcV
         RQgbYtzaj9EjCxC6vF/6oPulmUCDA6iCGBUwgVX8XSQUdowo0Vg6WNzcAFPL9nmVXxY0
         0ZxHGodCctNxv3yknnjLSlz9of4vAX7Sw3op5WFaRpIbQZKs784Vd09EOX+Ugpz8R9rj
         IL2TROKbJmLjpBcR0EqQ7f0Pk8D6vBalMFguI2UDisl1I0DNZg0ZDJTJYnzveSa2FYcA
         4zRw==
X-Gm-Message-State: ACgBeo0NNwmLv+hg4EJB+fZOLzjsBKsvRsbfpa4AI/CvPH+BZn3nTLAe
        v7Off2fHVVNL/VZ5MTWMCbSZ2A==
X-Google-Smtp-Source: AA6agR6T0S3GHapOEkuvZVWSZvxnakTwXjtf6NmVBM9YBxg+CfGLtCYEnFsRahjA9ta7k6QRkN6GkQ==
X-Received: by 2002:a05:6214:20cf:b0:476:c8d:6da6 with SMTP id 15-20020a05621420cf00b004760c8d6da6mr581223qve.98.1662503522308;
        Tue, 06 Sep 2022 15:32:02 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id bi3-20020a05620a318300b006b61b2cb1d2sm11855463qkb.46.2022.09.06.15.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 15:32:02 -0700 (PDT)
Message-ID: <ecd0497e-5623-0bf9-0160-79dca921a0a7@joelfernandes.org>
Date:   Tue, 6 Sep 2022 18:31:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v5 03/18] rcu/tree: Use READ_ONCE() for lockless read of
 rnp->qsmask
Content-Language: en-US
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org, vineeth@bitbyteword.org
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-4-joel@joelfernandes.org>
 <YxfJGYP2l0xbxxdr@boqun-archlinux>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <YxfJGYP2l0xbxxdr@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/2022 6:26 PM, Boqun Feng wrote:
> On Thu, Sep 01, 2022 at 10:17:05PM +0000, Joel Fernandes (Google) wrote:
>> The rnp->qsmask is locklessly accessed from rcutree_dying_cpu(). This
>> may help avoid load/store tearing due to concurrent access, KCSAN
> 
> Nit: you can avoid only load tearing with READ_ONCE().
> 

I modified it as you suggested for the next revision, thanks.
