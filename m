Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0D155DA5D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbiF0HOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiF0HOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:14:33 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596085F56;
        Mon, 27 Jun 2022 00:14:32 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a4so1424483lfm.0;
        Mon, 27 Jun 2022 00:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1vhD6QvwPb1Sk0ztcGCX9DIwPhwZXx+jWZOw6iM4IT4=;
        b=BAIkya7n14RIykaoNgFlpV/r3TQL/WNsEaKH7PY7aa/oang0UBV1YhJSag35l0RO6w
         VZ2j3uINQ3aQYfK8IMMSkPMQJQ3UxWe9/IB+/BxsB3XfbPFbvDwiiXtUMklAXqfefPC/
         Ckk9RqlYgDteapU5sKgZGFIQ/ggZJCHmKQuT8LwizCUd7q1m/NDwW+lXsEhfTUbzOUDE
         C5/gKwtALVMoIDRH8MQYaQr6N8BYuNvyuN7qcQA40dkTrEve4pDXkiBxmJmWr0z4TXOH
         1rurxGuK7Ua8OvElU3uPCrKKQEawbYW6BP1wCPdLiz01Hzq6f31aRsMGKl00SwNXSVXe
         XUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1vhD6QvwPb1Sk0ztcGCX9DIwPhwZXx+jWZOw6iM4IT4=;
        b=tbBfzrONuyQqpIodRRsfhfeBbcrikKbOFWYS+coNEqG5fEB42nX+x8yjcbdKst758K
         +Gd8HTbZ0F/cnnDKSnXTrPRbRtY/6a7hbJ+eloO44zYZWOKXMF/k373FkFlOje+XXKUa
         owpDLPCN5eaLNH9MfWUvX52SRhDGelPRPiRmZ/czmMqjZinSQxISvFpOQ1x4gWgoQxSy
         oecR/6tEoIK866PI5Q9SuskSqgOPH9D3A1RQHWFJyet2Rcm6mlNVpy+jIyMWBdUmqFUz
         HFnX1Zfq2xghUshJVrFbmWIsLNfHiTu2lZ3lvS9wimxUoVqCwVhJYtLaCmvxy0uRsBFZ
         93wg==
X-Gm-Message-State: AJIora9cPa/DUUwX+txWZyeAiG7saMJL/6+8o9aWOeelYSBWlI82GwJ3
        e7MQ8ZnJtQFOoZUA4wf3cTM=
X-Google-Smtp-Source: AGRyM1s3ipXM6rHscQ0lTPauWlKgFP+yMT68KWO8w0OHs08H9fUOh/0tp6DBqhGuWsgzcwouWyQTDQ==
X-Received: by 2002:a05:6512:3486:b0:47f:8790:85b with SMTP id v6-20020a056512348600b0047f8790085bmr8020143lfr.551.1656314070682;
        Mon, 27 Jun 2022 00:14:30 -0700 (PDT)
Received: from [192.168.2.145] (109-252-118-164.nat.spd-mgts.ru. [109.252.118.164])
        by smtp.googlemail.com with ESMTPSA id h18-20020a05651c125200b0025a91928236sm1292403ljh.90.2022.06.27.00.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 00:14:30 -0700 (PDT)
Message-ID: <ecc72279-0892-d5ab-689d-87b8fba5147e@gmail.com>
Date:   Mon, 27 Jun 2022 10:14:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 22/31] soc/tegra: Migrate to dev_pm_opp_set_config()
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <449b344f037c7ef1970bc84d31e0d4c4cb4d2951.1653564321.git.viresh.kumar@linaro.org>
 <20220624004831.po35sowzfo4c47b3@vireshk-i7>
 <20220624005700.oj4etaajbutvsym7@vireshk-i7>
 <73d39022-c6fc-0c21-cb68-9714846f02bf@gmail.com>
 <20220627064526.2nkezq4nufpkl4y2@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220627064526.2nkezq4nufpkl4y2@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

27.06.2022 09:45, Viresh Kumar пишет:
>> Looks okay. If you'll solve the cpufreq problem where OPP config is set
>> by two drivers for the same cpu device
> This is supported, there is some early freeing of resources on the
> removal path though, the reasoning for which I already gave in another
> email. Though, I am open to sorting that out as well, but nothing
> breaks the code for now AFAICT.
> 

In case of Tegra, we use tegra-cpufreq driver that sets supported_hw and
registers cpufreq-dt. If cpufreq-dt driver defers the probe, then the
supported_hw will be lost on the re-probe. I haven't checked yet, but I
suppose that cpufreq-dt driver defers on Tegra30 because of the CPU
regulator and that's why we get the "OPP table is missing" error.
