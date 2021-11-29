Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0533F461709
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241141AbhK2NyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbhK2NwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:52:19 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59320C0619E7;
        Mon, 29 Nov 2021 04:34:06 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id z8so34136662ljz.9;
        Mon, 29 Nov 2021 04:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9MEYf429fUYXIDY23BJq1xhaiBhvtCpqn2I4+Ys8Jv0=;
        b=iQdluKaDXA4s1LDQzwLm6lb4yGiY2CArQ2T6bn3Pz1BhK0xGp9VMoE7jlmqEEzifii
         5+zgpnWEsZNOmv6/lGFReJNoflZD4YISgoIL3kyzV529xXBOPftdZLBHAPFAfk2lR1XD
         /gJhSY4mlXjby51s6ZMUJPIVuTTRLKGTrAHxknBAcJ6zUCiCrJj0DvgSH5NyPQqppkpo
         Ug2OOdpYgy7Mdq01oyvpPRrWILRdHXQM50NEO41yEvOIspSJajiTxpRw6ChlS8rCB2Oc
         gfIc2KJ5NN//YoXht+iQHtKHB6zACjr2WfRW/YUfO+a+G6MdsDjxL7VchAIp2CTYwppb
         EWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9MEYf429fUYXIDY23BJq1xhaiBhvtCpqn2I4+Ys8Jv0=;
        b=nhLCgFxNCd2dhEIGdah0YJceLO4idzLsyCrNf80hCG6Q2X95Sn9sG9flTcB9NXa2Yr
         JAEsapQ4UFrtadg46Jfgw/dJLbHF2ChXIJm3KF/bCnwyatqw8vsIDmESQ0/3+I0ddAlh
         zlo9aUJG97gChpbejwqs+YIgDKy2pr0GolOBYvIP35vHAry+mX8+rsxCousXJMNjR6Br
         DQ/Y6rhGx2uEy/R4EF5WJTlhhipIr+YUWWotjYPAA542xFREmglHmmgHrpPaCYfjp3V0
         AlB+B74dgKtZKWkrsLQGXQWfzvrC3/ZuuA0XjuTV8xMLAByodLNpV46UFs+qcOGRxSnc
         rqew==
X-Gm-Message-State: AOAM530crzR/jSsOIbZSx6jW1ysgalRzEgQSBGbOXW1cBqzET1lKGv6N
        +vq3D721q2wwG4tM5fIz36IIDqmiG+k=
X-Google-Smtp-Source: ABdhPJyB6wwKuFxnDWJ4WlsmizSFmzVea+8g3fPsSsjtrpmleQDXgpx5avlKQ2GDUrpgneuh6UvgCQ==
X-Received: by 2002:a2e:9e8e:: with SMTP id f14mr48773558ljk.366.1638189244462;
        Mon, 29 Nov 2021 04:34:04 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id o2sm376987ljd.85.2021.11.29.04.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 04:34:04 -0800 (PST)
Subject: Re: [PATCH] serial: tegra: Fixes lower tolerance baud rate limit for
 older tegra chips introduced by d781ec21bae6
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Patrik John <patrik.john@u-blox.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        ldewangan@nvidia.com, thierry.reding@gmail.com,
        jonathan@nvidia.com, linux-serial@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <sig.096060f39c.20211122124425.74031-1-patrik.john@u-blox.com>
 <YaK9DwsgGr8eaMuX@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7242bcd6-bb40-dc21-31b9-051429b89122@gmail.com>
Date:   Mon, 29 Nov 2021 15:33:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaK9DwsgGr8eaMuX@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

28.11.2021 02:19, Michał Mirosław пишет:
> On Mon, Nov 22, 2021 at 01:44:26PM +0100, Patrik John wrote:
>> The current implementation uses 0 as lower limit for the baud rate tolerance which contradicts the initial commit description (https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/commit/drivers/tty/serial/serial-tegra.c?h=for-next&id=d781ec21bae6ff8f9e07682e8947a654484611f5) of +4/-4% tolerance for older tegra chips other than Tegra186 and Tegra194.
>> This causes issues on UART initilization as soon as the actual baud rate clock is slightly lower than required which we have seen on the Tegra124-based Toradex Apalis TK1 which also uses tegra30-hsuart as compatible in the DT serial node (for reference line 1540ff https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/tree/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi?h=for-next)
>>
>> The standard baud rate tolerance limits are also stated in the tegra20-hsuart driver description (https://www.kernel.org/doc/Documentation/devicetree/bindings/serial/nvidia%2Ctegra20-hsuart.txt).
>>
>> The previously introduced check_rate_in_range() always fails due to the lower limit set to 0 even if the actual baud rate is within the required -4% tolerance.
>>
> [...]
> 
> I have a same patch waiting in my tree [1]. Feel free to use the commit
> message and to add:
> 
> Reviewed-and-tested-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> 
> [1] https://rere.qmqm.pl/git/?p=linux;a=commitdiff;h=b658dcd83d0db777410fe960721193d35a38115a

The Reviewed-and-tested-by isn't a valid tag, should be two separate tags:

Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Tested-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
