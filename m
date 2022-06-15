Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C244154C67B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344465AbiFOKuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243605AbiFOKuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:50:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57F4637A20
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655290220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uHh98GFud1PPMa8LMkyMEyW14ccPkBQOH1hhbDcKaMg=;
        b=eWa94p5GQyrGndI+0cPT/M6x5R5KSKzRjQJQrXXnqT4LColROrpTRyVVy1tFIFZMo4X0xR
        uj0G5utEbBL8DY6/8o9Kx+nwsrusJmxPpC7MMHZJ8KcTC/Ada2M9uSk8mvrt5tG+tOV8ca
        YU4vFu9cNMQxG3MrT3qxpaCWAjOjNi8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-s4VAArG8M7y3nyNdKF4rqQ-1; Wed, 15 Jun 2022 06:50:19 -0400
X-MC-Unique: s4VAArG8M7y3nyNdKF4rqQ-1
Received: by mail-wm1-f69.google.com with SMTP id be12-20020a05600c1e8c00b0039c506b52a4so1427000wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uHh98GFud1PPMa8LMkyMEyW14ccPkBQOH1hhbDcKaMg=;
        b=Kk78iTTFiyq5vs/QcvbN6yFpQoCT4gCt2OwoeR4ePytnL4UX39Jtte2mqHm1UM3XRE
         M8URPGlcoD7FKK5RzMg8PHRm7tw+FTGTP/CUiw7uiVwGedVMQWItrSnUrwhBrQqVtJHL
         I8/01VF20NvBoHTlTBNZvTaEt8Lm1iV4KkP6FIMT9bbeHfnDEGRhfC98XxArL1+ClaK5
         NEUqa3GaN+Plnv73eR5yB7DeErTEjShTMLJn9UxrUK4PZEjitKFBH78kXV94qtszyzS7
         jgYE0ZG+GtN+qRck71OfXZ1Z7lLxnhSXxbEFk5l0MGnplfnaNRGiOrQZ2y5BIuTbKOwy
         Odhg==
X-Gm-Message-State: AJIora9OTQBCnMqiHGHAM6nB2atQRwjOoR0kXqrg5Ol8y8FYsDmnDvuf
        6pC/hk5QMnoizdFtA9qzaZ/UjU72EP6GemscBbhJLXODoMaSIilFl25jYXvZZcFV2pjFV3yHKiT
        y5sLcOOpC9WD76MnlXrQ2agrM
X-Received: by 2002:a05:6000:1861:b0:216:4519:18a1 with SMTP id d1-20020a056000186100b00216451918a1mr9255319wri.293.1655290218120;
        Wed, 15 Jun 2022 03:50:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ujJGQ91NoFzb7pWEePHMU1Lak91ztKOlNz2p9lEbfC2Vj6Sv1ENCei3nz6jG854BqJTQtsEA==
X-Received: by 2002:a05:6000:1861:b0:216:4519:18a1 with SMTP id d1-20020a056000186100b00216451918a1mr9255298wri.293.1655290217900;
        Wed, 15 Jun 2022 03:50:17 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id m6-20020a05600c3b0600b00397402ae674sm2044200wms.11.2022.06.15.03.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 03:50:16 -0700 (PDT)
Message-ID: <7f6d9360-9254-88d6-fb34-13f248d2e542@redhat.com>
Date:   Wed, 15 Jun 2022 12:50:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking
 readers from consuming CPU) cause qemu boot slow
Content-Language: en-US
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
        paulmck@kernel.org, zhangfei <zhangfei.gao@linaro.org>
Cc:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>,
        Auger Eric <eric.auger@redhat.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>
References: <tencent_E306F58EAEC1D188ED6D5F358A269F34C707@qq.com>
 <20220613035711.GY1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220613041652.GA3976000@paulmck-ThinkPad-P17-Gen-1>
 <tencent_F82250B6E3D51A9AC0D2BE1AE43A4E060909@qq.com>
 <20220613121831.GA1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_65C7D0A04984EDB6A79A5E5379DA7E835206@qq.com>
 <20220613145900.GC1790663@paulmck-ThinkPad-P17-Gen-1>
 <7b6c983b21d44119b61716a66de397ed@huawei.com>
 <f9684a69-5467-a440-abd1-7cf5ad3a81f7@quicinc.com>
 <tencent_8FD344DA7FC376C7D1204604DA7689DA4906@qq.com>
 <20220614141712.GR1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_DFF5A6C9352C76C00C7E46E06F2BA945350A@qq.com>
 <042142db-aab2-fc4a-c1a5-371223c80440@quicinc.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <042142db-aab2-fc4a-c1a5-371223c80440@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 12:40, Neeraj Upadhyay wrote:
> 
> This is useful data, thanks! Did you get chance to check between 100 and 
> 1000, to narrow down further, from which point (does need to be exact 
> value) between 100 and 1000,  you start seeing degradation at, for ex. 
> 250, 500 , ...?
> 
> Is it also possible to try experiment 10 and 11 with below diff.
> What I have done in below diff is, call srcu_get_delay() only once
> in try_check_zero() (and not for every loop iteration); also
> retry with a different delay for the extra iteration which is done
> when srcu_get_delay(ssp) returns 0.
> 
> Once we have this data, can you also try by changing 
> SRCU_RETRY_CHECK_LONG_DELAY   to 100, on top of below diff.
> 
> #define SRCU_RETRY_CHECK_LONG_DELAY  100

Is there any data that you would like me to gather from the KVM side, 
for example with respect to how much it takes to do synchronize_srcu() 
on an unpatched kernel, or the duration of the read-sides?

Thanks,

Paolo

