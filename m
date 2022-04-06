Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D6E4F6C98
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbiDFV0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbiDFVZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:25:43 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD35B6;
        Wed,  6 Apr 2022 13:21:01 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id j8so2951085pll.11;
        Wed, 06 Apr 2022 13:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3mCDtib46azYhoHX+oJIxgCRBmS2BXiXfAVoUab2E94=;
        b=G/IakRoTiAI0cvScoaTKDrEAtYKZlUYKKy1nKDsjiU+2JCkytRwqvIhWSlYkzzu2UP
         /pC8bSSOL9fXe1mntksjHBwt4/qDkr49OyaQdYurlfKhU3iB2T/LWCxGviFSxYqzktns
         ditxD6t8mR2QT/2g+Fo8NsvnUD09JKot3+3tJduNVRminyvWw0sJOk1f9rVLyXdRp+MV
         1/15Ra1zkLd3GyrzmeT6KWROsuFtBZHjRg9lxjDh8oCfzNz3Cu0YPBb5VJreliZquwsc
         W6RMZtepyu6DRTxXOL3LTjjtSUCu6iQpJ+SHUQwm9vsnnG2NJyT2+EYtYR7xsj+dOfNn
         zjIA==
X-Gm-Message-State: AOAM530LnSArg00wUxm7sZxts/G5W1SBNK0/D9KLfDwYH8QwHnDDOYjV
        EDW5zrt6ihIYJiiNOpEBRps=
X-Google-Smtp-Source: ABdhPJxMJ3dzw7N9XtYfZUeTBt4fqiJFyiCzT9SQ10HzjeqEzZaDG86sXBMGiVqyHmM+u0AmHyV3iQ==
X-Received: by 2002:a17:90b:3a81:b0:1c6:834e:cd61 with SMTP id om1-20020a17090b3a8100b001c6834ecd61mr11840281pjb.149.1649276461210;
        Wed, 06 Apr 2022 13:21:01 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090a784c00b001c6bdafc995sm5468971pjl.3.2022.04.06.13.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 13:21:00 -0700 (PDT)
Message-ID: <b95bdfa9-4373-8f54-677e-4a764061c61c@acm.org>
Date:   Wed, 6 Apr 2022 13:20:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
Content-Language: en-US
To:     Bean Huo <huobean@gmail.com>,
        =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc:     linux-kernel@vger.kernel.org, maxim.uvarov@linaro.org,
        joakim.bech@linaro.org, ulf.hansson@linaro.org,
        ilias.apalodimas@linaro.org, arnd@linaro.org,
        ruchika.gupta@linaro.org, tomas.winkler@intel.com,
        yang.huang@intel.com, bing.zhu@intel.com,
        Matti.Moell@opensynergy.com, hmo@opensynergy.com,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20220405093759.1126835-1-alex.bennee@linaro.org>
 <8b3ce88f65fd11523a4d2daab3c617f7089eb1ce.camel@gmail.com>
 <87r16bk013.fsf@linaro.org>
 <aeb64d1c4bbddfd8463c07a40ab1fc78be0d158d.camel@gmail.com>
 <87ee2ajuky.fsf@linaro.org>
 <c18a2b359046a14250cafa5a619dbe53f2872b5a.camel@gmail.com>
 <e72812a9-1e5b-a826-d490-62ed23d94116@acm.org>
 <310d20a04bdaf40672592d9ffa950606d2ceaff7.camel@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <310d20a04bdaf40672592d9ffa950606d2ceaff7.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 11:12, Bean Huo wrote:
> It is from the ufs-utils.
> 
> So, do you vote to add the UFS RPMB driver based on this new framework
> to resolve this conflict?

Are any applications using the RPMB code from ufs-utils? It seems to me 
that the ufs-utils code doe not handle SCSI unit attentions correctly. 
If a POWER ON unit attention is received as reply to a SECURITY PROTOCOL 
OUT transaction, the write counter should be reread instead of retrying 
the SECURITY PROTOCOL OUT command with the same write counter.

Regarding adding a UFS RPMB driver: that seems useful to me since 
multiple applications make use of the UFS RPMB functionality. My 
understanding is that currently storageproxyd multiplexes UFS RPMB 
accesses in Android.

Thanks,

Bart.
