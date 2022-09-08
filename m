Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAF25B28EE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 00:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiIHWC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 18:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiIHWCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:02:53 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31046226;
        Thu,  8 Sep 2022 15:02:52 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id t6-20020a17090a950600b0020063f8f964so4295933pjo.0;
        Thu, 08 Sep 2022 15:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=b12taMnIzdMKm4jddAntJRZjOPMuOvjwagtVtJORdzI=;
        b=pq1zBUWfMR3nUFc4rN2pj6sxK5EUoYvSLnQlNAWedj6PaZR6LUZ7BRxohIpYGzRZI3
         f1PMQwIkNnW+huLZSsP34rVpxdowygya+BHc0EA7TiYrhjezC4+h8dUnrMTFqi+4N2dW
         IqV9lt1ax2dAPYkdSRK/UNLS8BYTCO2ewjeUqy9sKOJ3n4vNs8KRz8URIrHnJkb/tlKh
         56pFJNLjimWb3xOQHx8JOmwHIp50bCk3T+eQx588kwp3t2AK6oxmvE5LUABh0y/rDig7
         qmO60H1ujiAAWOv7zoX35LbxvWXFzkXFyMEe89RsJrzzowVYpiLiUnPgQrEsJG0JCn6g
         b1kw==
X-Gm-Message-State: ACgBeo0xyZK73aB8ZnzZVW9vHi5R0x2O/BzgFBAldNT9r9BwDpVdayKA
        9zB/kISUdbv8uOrxsh18Xvk=
X-Google-Smtp-Source: AA6agR6pTB2tPVoMwzw7k4ZKmtCcnvQ4r6tBR0MR1NlBGJdXUd+qKpMCTXAozXCSSiKuB1tqLquBXA==
X-Received: by 2002:a17:90b:3a89:b0:200:5a01:e3a6 with SMTP id om9-20020a17090b3a8900b002005a01e3a6mr6334666pjb.64.1662674571626;
        Thu, 08 Sep 2022 15:02:51 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:c18a:7410:112c:aa7c? ([2620:15c:211:201:c18a:7410:112c:aa7c])
        by smtp.gmail.com with ESMTPSA id 201-20020a6217d2000000b0053e5daf1a25sm108199pfx.45.2022.09.08.15.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 15:02:50 -0700 (PDT)
Message-ID: <877d782d-8fb1-44bc-6de9-1c3c7f8667f3@acm.org>
Date:   Thu, 8 Sep 2022 15:02:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH v3 2/4] ufs: core: mcq: Adds Multi-Circular Queue
 support
Content-Language: en-US
To:     Bean Huo <huobean@gmail.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        avri.altman@wdc.com, mani@kernel.org, quic_cang@quicinc.com,
        beanhuo@micron.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1662157846.git.quic_asutoshd@quicinc.com>
 <04f4949e4dea991a93bdf6727bf12948ecc586be.1662157846.git.quic_asutoshd@quicinc.com>
 <c3d2d8b307f7e11b7a2be751673220049b9a1a77.camel@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c3d2d8b307f7e11b7a2be751673220049b9a1a77.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/22 09:27, Bean Huo wrote:
> static read_queues is not initialized.

Hi Bean,

The Linux kernel coding style guide does not allow to explicitly 
initialize static variables to zero. The C standard requires that static 
variables that are not initialized explicitly are initialized to zero. 
 From https://en.wikipedia.org/wiki/.bss: "In C, statically allocated 
objects without an explicit initializer are initialized to zero (for 
arithmetic types) or a null pointer (for pointer types)."

Thanks,

Bart.
