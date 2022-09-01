Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D385A98ED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbiIANdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbiIANce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:32:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EEC2717E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662038926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KHTa+FWm7oeImzoRnoqlC6BBTOOK+4vjj/5kjcEi/vc=;
        b=P8z3x0iL7wGlTs0iT3SBPQNx9HRsEWZS35LCAGnwqgqHDT3OxGqsbOBRmpoQtbvJNxKyeN
        pQqkXXU+VT299oD/KWkw2P+jfsAL/9I49U0e9IQ6hCt4q1/7vsEo/Hp6VTh65CFgdraADl
        1iNSSR72QhOEiYUqXralHou5glv9E4o=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-620-aPjrdoRaNT-CCW4tqM_37w-1; Thu, 01 Sep 2022 09:28:45 -0400
X-MC-Unique: aPjrdoRaNT-CCW4tqM_37w-1
Received: by mail-qt1-f199.google.com with SMTP id bq11-20020a05622a1c0b00b003434f125b77so13763030qtb.20
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 06:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=KHTa+FWm7oeImzoRnoqlC6BBTOOK+4vjj/5kjcEi/vc=;
        b=HCNDeH7c9TjDluz5ihvfCNzN6Al6GmNSHJPbUDoFowvCJMS2HSAMYKXiZ1OB9tOB+l
         +KHHh3M0iMAS1ysx3GLx+xWzKv/fjiwQ2yZmyH3qBn9mDmDOj5EYFyLbS1djAmH7tRyr
         EzKBJKtWbk1sTCXUoDuQuhEQpinlmUj0ED5dnE+xOErfzM93xlaLAfowAG3WO7xEgACL
         vbuNaTF6KyM81/yWt2vd03gEHZKIAi7WaH492TkJb+V4qpc/kKe0Q1Ls3zzsbGHVGret
         l3SQslGs2pHWkSkilkFiC9Z6Hh4o96M5tHfjX+Q+YmDdlzEbbkYVm/dRM9zlViRdFeaX
         cIcg==
X-Gm-Message-State: ACgBeo3nDmPTT+7kSyHY/9a83ZjuK5XvG5nEqdATjPOTe1BhIqOP8TZI
        WvZlxXDrMeEaMlJp/5NLYMSk+asukIUH1tZ12mlbYIi8u98y+a+G50mbxs0BPGMll6rlly+T3n2
        lEEYHmzPHseoKtO53rPaze2rV
X-Received: by 2002:ad4:5bc1:0:b0:499:b05:734d with SMTP id t1-20020ad45bc1000000b004990b05734dmr14543342qvt.37.1662038924383;
        Thu, 01 Sep 2022 06:28:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4sa9iHl0nVSYhctkGtjgto7IhCUw1KueymhwCuwA43bg4yzH3mbmtccFPxjgoDpFEB0VoAag==
X-Received: by 2002:ad4:5bc1:0:b0:499:b05:734d with SMTP id t1-20020ad45bc1000000b004990b05734dmr14543328qvt.37.1662038924132;
        Thu, 01 Sep 2022 06:28:44 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-72.dyn.eolo.it. [146.241.112.72])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a430600b006b893d135basm11897700qko.86.2022.09.01.06.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 06:28:43 -0700 (PDT)
Message-ID: <306bd3cb986764e60f7ac21809ab68094b2e3325.camel@redhat.com>
Subject: Re: [PATCH next-next 0/2] net: vlan: two small refactors to make
 code more concise
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ziyang Xuan <william.xuanziyang@huawei.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, morbo@google.com,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 01 Sep 2022 15:28:40 +0200
In-Reply-To: <cover.1661916732.git.william.xuanziyang@huawei.com>
References: <cover.1661916732.git.william.xuanziyang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 2022-08-31 at 12:09 +0800, Ziyang Xuan wrote:
> Give two small refactors to make code more concise.
> 
> Ziyang Xuan (2):
>   net: vlan: remove unnecessary err variable in vlan_init_net()
>   net: vlan: reduce indentation level in __vlan_find_dev_deep_rcu()
> 
>  net/8021q/vlan.c      |  5 +----
>  net/8021q/vlan_core.c | 22 +++++++++-------------
>  2 files changed, 10 insertions(+), 17 deletions(-)

The patches look correct to me, but I think is better to defer this
kind of nun-functional refactors to some work actually doing new stuff,
to avoid unneeded noise.

Note that I merged a few other clean-up recently, but e.g. they at
least formally removed some unneeded branch.

Sorry, I'm not going to apply this series.

Cheers,

Paolo

