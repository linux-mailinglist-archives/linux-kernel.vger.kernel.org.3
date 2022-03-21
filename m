Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73A54E23A6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346040AbiCUJyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346031AbiCUJyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:54:04 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981E59F6E5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:52:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r23so17197223edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DC935hNdJZg7Mae6w6qpYtJ84MUCDnWV3o5C6lnKsKI=;
        b=VKyHserT+1U5tbxrdYbVF91hsVxJ2hcKxQjgOuBFswAj4w2IqsOaPRHzx4s3b1btex
         EGVyzOLTZ2+73xVhEf2smpJThhxQ1VQC7AV3r40AxaoqeECwy27Q7AoPOH0ps/+YmPZw
         OEgLhcX+A5N/FTxvXAJZ+PkrQmTHyUz/kOmqiodd0pJt7GX/e4YXOKyqP6EcUzVjzxjI
         OqrO0fbIvoFYIeUFaU77HeLqKJCbB1O8dm0dQ+L2fpFySif4/P05Y7Jd2qZY1ddIpIbT
         uMz9hxV3dobTsA4GjNoyPM7yk8A07f8EXuI6OBH6/J7csgMvWqDNlrpOnO907Zvtq4Gt
         N25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DC935hNdJZg7Mae6w6qpYtJ84MUCDnWV3o5C6lnKsKI=;
        b=r+mP48zjvPXi7dnB4qVfoOUkJDN3WX9W+gQ2Dt1rfVCwA9pcEStK/XUQPw19oGA5CZ
         rTdNN/sbFQSPGju5+8sLFwon1+DvNu1RqEnZj2KIfI6EeZNL3qXtaD4XflSAcOMYk2pj
         KLWlNqjWovOeHgez1+cqVaMNxxoo37SUVvYAa/6PYPEY04SaMeee4r2NPg+ahYp2G0B1
         pdWr5BR/adJBcGTWUV6RngzaOdasKxXcewTwl3WTGKonQfRmuDQoeAs0xvPGTY22SWnG
         sgYng+Ogdl1m0W2fOEjYp2hvYv+6UN+eMiILvSNfXWZadYKbbQf/MUKYW7spk/HZvRrR
         izQA==
X-Gm-Message-State: AOAM533QwsXPYP4IF2/dhlRcKO1S8Bjw92wsutnrz2AmaDrUrdLdvMnB
        E3+HkyrP61hjND3ADGWSIE5xRA==
X-Google-Smtp-Source: ABdhPJxdG8gdI5IGVfAj95JNfdvqLcTgbfgdPg+reZ6PAGfsub7qZLBjDJhrtj/V6hOeYFTJYxOIDA==
X-Received: by 2002:aa7:d553:0:b0:416:4dfc:126d with SMTP id u19-20020aa7d553000000b004164dfc126dmr21526998edr.213.1647856357101;
        Mon, 21 Mar 2022 02:52:37 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id f5-20020a1709067f8500b006da68bfdfc7sm6657289ejr.12.2022.03.21.02.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 02:52:36 -0700 (PDT)
Date:   Mon, 21 Mar 2022 10:52:35 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     =?utf-8?B?5a2Z5a6I6ZGr?= <sunshouxin@chinatelecom.cn>
Cc:     j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        davem@davemloft.net, kuba@kernel.org, yoshfuji@linux-ipv6.org,
        dsahern@kernel.org, oliver@neukum.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, huyd12@chinatelecom.cn
Subject: Re: [PATCH v4] net:bonding:Add support for IPV6 RLB to balance-alb
 mode
Message-ID: <YjhK43MgpFkLFDhS@nanopsycho>
References: <20220317061521.23985-1-sunshouxin@chinatelecom.cn>
 <YjLtLdH9gmg7yaNl@nanopsycho>
 <1f7b15a6-861f-9762-a159-73d16c95eebc@chinatelecom.cn>
 <YjRuXPJzp2fKvMst@nanopsycho>
 <e24c1190-ba41-6ba5-0aca-463cac2a2b2f@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e24c1190-ba41-6ba5-0aca-463cac2a2b2f@chinatelecom.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Mar 21, 2022 at 02:17:34AM CET, sunshouxin@chinatelecom.cn wrote:
>
>在 2022/3/18 19:34, Jiri Pirko 写道:
>> Fri, Mar 18, 2022 at 10:49:02AM CET, sunshouxin@chinatelecom.cn wrote:
>> > 在 2022/3/17 16:11, Jiri Pirko 写道:
>> > > Thu, Mar 17, 2022 at 07:15:21AM CET, sunshouxin@chinatelecom.cn wrote:
>> > > > This patch is implementing IPV6 RLB for balance-alb mode.
>> > > > 
>> > > > Suggested-by: Hu Yadi <huyd12@chinatelecom.cn>
>> > > > Signed-off-by: Sun Shouxin <sunshouxin@chinatelecom.cn>
>> > > Could you please reply to my question I asked for v1:
>> > > Out of curiosity, what is exactly your usecase? I'm asking because
>> > > I don't see any good reason to use RLB/ALB modes. I have to be missing
>> > > something.
>> > > 
>> > > This is adding a lot of code in bonding that needs to be maintained.
>> > > However, if there is no particular need to add it, why would we?
>> > > 
>> > > Could you please spell out why exactly do you need this? I'm pretty sure
>> > > that in the end well find out, that you really don't need this at all.
>> > > 
>> > > Thanks!
>> > 
>> > This patch is certainly aim fix one real issue in ou lab.
>> > For historical inheritance, the bond6 with ipv4 is widely used in our lab.
>> > We started to support ipv6 for all service last year, networking operation
>> > and maintenance team
>> > think it does work with ipv6 ALB capacity take it for granted due to bond6's
>> > specification
>> > but it doesn't work in the end. as you know, it is impossible to change link
>> > neworking to LACP
>> > because of huge cost and effective to online server.
>> I don't follow. Why exactly can't you use LACP? Every switch supports
>> it.
>
>
>Hi jiri
>
>
>Changing to Lacp means risk  to our online service requring high available.
>
>Also,we have multiple DCs installed bond6,it is huge cost to change it.

So? This is 0 argument in this discussion. I believe that adding this
amount of code to bonding for use case that could be simply replaced by
LACP is wrong and we should not do that. The oridingal ALB/RLB
implementation was done when LACP was not that widely used. But now it
is 2022 - different story.
