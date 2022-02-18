Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BDB4BB056
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 04:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiBRDoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 22:44:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiBRDoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 22:44:11 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F210B219C3F;
        Thu, 17 Feb 2022 19:43:54 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id z4so6724424pgh.12;
        Thu, 17 Feb 2022 19:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wv/+n1Q+HAlLjb+w4/QeMPmoHd/JEq3IFMjhLXwWxzQ=;
        b=aJbjhGQskGCoVVjFhLItRaAo1qPKhpkkmVjlYIVG65cmQBfWk4+Sp66V47DcqjJH2n
         oG8E0G0G0cKp0z1jaDeSz0PjvhXdnPXdQpqfosnhRmAgcYdBbpumtFeuhIUGXhNSj0Lm
         hravh2vemKlHEBfg75oUxLSeMdhN2oUyS4SFiq7gmhIHZ3Fuhur0936faFbqkCjjLq+X
         +N/6tG36u9ivq+rsl7tPaCg2M+byCnQk9O6inn7wtfJhsOhRAmQ4v7QoRVMwidlpw1rb
         xSrOTj4Dk3wHmZy0qTyaZ1lGwM/LH8TeWZzHus6o2/HGPMOxNGPajWknfkFhwBKc/4gP
         6uOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wv/+n1Q+HAlLjb+w4/QeMPmoHd/JEq3IFMjhLXwWxzQ=;
        b=KqOzTM+IsT6F+K2F+vNr49CPiHGwr40UECxvqZ54lR9IXM2ADuNoHvbzGZt7JrJY/H
         KGzJZcTR/YqKcIX10ocNgvnShrMhYfY550zXWqJAzatVtXxjUTsAL0TSdq16UunxWGP0
         n+ujAwp8xh3iPnxx4pDEBujxFKiMSiDFXJIj5nDCEIrlpHMY9y85Mxz7TGvqDc3Kdq0/
         zszLGmPUtkHGD7rJmHlkxi2Q2syw/I7DKNBtDActXireDZstvHKVQ0KYH4GvZyjNRr3p
         Yny6Ec/6LW+dwA2JNebmBfOZslmtAFc9tFSugkpjQovPAxwnqOV1Yxv2Com8d12GLeGP
         +iLA==
X-Gm-Message-State: AOAM533fSloJi6PSfH6bBhc4nMgrk46ipLWR8QvLN1zgIpBQ4yL/iqL8
        D4rAQSjG/0LPjyiuM3TEtD9nhjNoduDTeA==
X-Google-Smtp-Source: ABdhPJxw+c2WLxlMvpFAAGvxIOO++8RTCSUUYCG8f58peZoY29HDT1AptigeGTZYxcvvl4AiBe1WfA==
X-Received: by 2002:a05:6a00:b86:b0:4e1:954e:4f04 with SMTP id g6-20020a056a000b8600b004e1954e4f04mr6166140pfj.33.1645155834545;
        Thu, 17 Feb 2022 19:43:54 -0800 (PST)
Received: from [172.20.119.15] ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id lk11sm3634526pjb.31.2022.02.17.19.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 19:43:54 -0800 (PST)
Message-ID: <88622875-4a96-111e-93d0-6a10e4306ada@gmail.com>
Date:   Fri, 18 Feb 2022 11:43:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [RFC V4 6/6] blk: export the sysfs for switching qos
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
 <20220217031349.98561-7-jianchao.wan9@gmail.com>
 <Yg4Necp/xHXWvoDM@infradead.org>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
In-Reply-To: <Yg4Necp/xHXWvoDM@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/2/17 4:55 下午, Christoph Hellwig wrote:
> On Thu, Feb 17, 2022 at 11:13:49AM +0800, Wang Jianchao (Kuaishou) wrote:
>> -static const char *rq_qos_id_to_name(enum rq_qos_id id)
>> -{
>> -	return "unknown";
>> -}
> 
> Please split the removal of dead code into a separate patch.

Got it

Thanks
Jianchao
