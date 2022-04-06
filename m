Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BA34F6377
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbiDFPg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbiDFPgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:36:10 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E1C11141
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 05:50:12 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id n8so1864444plh.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 05:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aPPsZoyEXy9EAC2N5qG3x7kPyndDAP9GgwcMMI/+/zg=;
        b=yPKyjFG+pRyoMpVw0irL0ZYiN+FH3aspIwhFJEkEraHCnf6dro4sRYgPZux/bqBRV3
         WdNXiG9XfExo+Vur5TOIQiiAH4HDBP76Z3qJ5j/UA8Gb3Id/e4zn7s7mW2aAxrZ298J7
         UJ/l/hPDp1qDw9rf5R1oJ47Ms0iNCZuJ/+vNPLdKWU0Fd1Bb3cHmAfedjqotfupqmyj9
         +wwex2ovMk+maTQDgzHSmBaplqIh0LZzxsG3ocv64NUUWqd4Mh5D83tBNAdh9vbYNlm1
         FL2bDSfAmPMrf/G3OTBb9J1I9KKo0Ikv2mRI1QjQ/yEMk3jm/o729sb3N9RE+RhUvCfr
         rRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aPPsZoyEXy9EAC2N5qG3x7kPyndDAP9GgwcMMI/+/zg=;
        b=eyDBPSCsPEPZ/zSTh5kpiWZ4ddsi4RMwpOvlXBIM7RdpAM/1ZmET4vzjLLg81XdbxS
         D4svOeO9nxX9pjdlQq4JOjsqd7C5hBbjasJ8MZYtL4KanLmXu+csEKpbXY91ezJEff1F
         FbIOa2w9jCDeAI2Y6oXu9Y1voR0RCGxZAmlDsly6KYkDmbnl6QEqmWGBKSgoYzDNYgiY
         EXQ39/RB37Jflk4NFjWyaUi0QhTcc9k8CzFWNDNjeDxOMPvsci4OJt4mlJEEmdo21QMS
         zDLQnsjYpTMFlCEUuzngyaop84eRHS993HQ5u1GynWTSRorK4ELafyx+bjJTdRW7af4X
         OxMQ==
X-Gm-Message-State: AOAM530O0RF/xwaROilrQoMNivpxtea9Z/T7IjL36vKmQ+E+IXHx1aya
        Al581VSCYLLT8X8VwdRP53wfBQ==
X-Google-Smtp-Source: ABdhPJwsHnAf9g/k8zv+l6CsgXyrm9yUcEPll30bEgr9FsWB6khxifAB4uf/jcBQ/NXwxScuCLooTQ==
X-Received: by 2002:a17:90b:38d2:b0:1c6:fa94:96bb with SMTP id nn18-20020a17090b38d200b001c6fa9496bbmr9726947pjb.206.1649249289572;
        Wed, 06 Apr 2022 05:48:09 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id na6-20020a17090b4c0600b001cac43b549esm5901496pjb.43.2022.04.06.05.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 05:48:08 -0700 (PDT)
Message-ID: <edc53d1c-bdea-f070-34bf-33eefb715356@kernel.dk>
Date:   Wed, 6 Apr 2022 06:48:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] io_uring: implement compat handling for
 IORING_REGISTER_IOWQ_AFF
Content-Language: en-US
To:     Eugene Syromiatnikov <esyr@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artem Savkov <asavkov@redhat.com>
References: <20220406115533.GA5165@asgard.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220406115533.GA5165@asgard.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 5:55 AM, Eugene Syromiatnikov wrote:
> Similarly to the way it is done im mbind syscall.

Thanks, applied.

-- 
Jens Axboe

