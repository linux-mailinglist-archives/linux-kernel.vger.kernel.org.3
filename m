Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F42C4B0216
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiBJBZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:25:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiBJBZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:25:34 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA94FCD
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:25:36 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id n17so5532970iod.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 17:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EUYeXYnwPWQAai7d38TfE6Low6Zia8y6c+gv6WqQKdw=;
        b=V4yJnLf0kcj8tup+654gTlpzbRrpgrGzjiS9jcsVoMYBly/G4e7Yhwc4WrJQ4QRj9c
         w3hPKqi6zYx/EMa3wlW5B25sj6nuzxoaj2fogjxhdHEUnKCoEQOi6JSa8GiZWZuqX/7F
         1mbxE7dzO3LFu5/DXjX3Z7zaew86O9/rKFmKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EUYeXYnwPWQAai7d38TfE6Low6Zia8y6c+gv6WqQKdw=;
        b=5Lm0aRb4aum1+CNYwTGIRHrRtiyItIxOpcyL8bWLOeo0g0fPnuE/BjLDcq8yRswHfL
         +tBgOkuVK/rU6Mc4WlgEuI8yTyZhDgodkVTx62+qcPX9oepBA9XKEtCCfTANbfDnnahR
         dqieGYyNO1WDYEc5v12gOKFeLN2c76dmQDyMwCtXByRY+hIE9gwYStaG5gu170bxFQH9
         0UqUg3wR+BSA9tjoQ+QeAsz8KEjxWcrO+Wcx+tC+6XAHPeu83L1BRAQrSVvgPyp5P6RV
         3vq1E27tpTOB1yww//rDGa39zzK37LB6R9VEFkunsCi0isWpnN251gErVrjQd+43Giv+
         HPsA==
X-Gm-Message-State: AOAM532BbwbFjIDYS7pnyuXzks2dmm7tL+GLFtcymNcYoouuL70wc3I1
        GWm5GAWBpRJ7icGxdo5nbaAEqA==
X-Google-Smtp-Source: ABdhPJzDIQtC64qzn1zaIQABw7VqVnWjqVO0aTcoRuuZp/AmllgRfvy7K87XiLYoQA4Cg74uu4d/XQ==
X-Received: by 2002:a05:6602:2e16:: with SMTP id o22mr2663900iow.10.1644456335723;
        Wed, 09 Feb 2022 17:25:35 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id r9sm10720341ill.52.2022.02.09.17.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 17:25:35 -0800 (PST)
Subject: Re: [RFC PATCH 6/6] selftests: Test RLIMIT_NPROC in clone-created
 user namespaces
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220207121800.5079-1-mkoutny@suse.com>
 <20220207121800.5079-7-mkoutny@suse.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <789bda88-1ef7-8c60-5c00-d3b7a2b8588d@linuxfoundation.org>
Date:   Wed, 9 Feb 2022 18:25:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220207121800.5079-7-mkoutny@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/22 5:18 AM, Michal Koutný wrote:
> Verify RLIMIT_NPROC observance in user namespaces also in the
> clone(CLONE_NEWUSER) path.
> Note the such a user_ns is created by the privileged user.
> 

Does this test run in non-privileged user mode? If it doesn't
let add a check and skip the test.

> Signed-off-by: Michal Koutný <mkoutny@suse.com>

thanks,
-- Shuah
