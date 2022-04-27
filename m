Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CD351196A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbiD0NpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236239AbiD0NpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:45:05 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4A91A860E;
        Wed, 27 Apr 2022 06:41:54 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id e4so2004010oif.2;
        Wed, 27 Apr 2022 06:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jVsBIt3UuAl5LSk1ZswruBzMsu6E7SfYBM1V38VtIU4=;
        b=JN8QSxbNLwNK10iX074XBXxMlK8lieMITwzr7NLvM3uOygVU/0Q/nGVNgiu0TOSrwL
         9JZExfB7w2rjDUkmnb+3Nih+4Ae2+sb1MiNRG6yv1iAChZM8/AuE4qH1Omy0WZmESHKC
         zI8h2+HQQuzUsXv8ks6cGoGwwbNN+8f8sBjySXlHO4h7/sdRW69B30n3UknR1YHihOD9
         GdfvV7yNvaQTjmyirv3l75Ww5GnH4LXqiGXc4IrJsiBbzhvyBMQZININYavNj2WKIJQx
         xndQOMgtaUbAdCCM8BPA/OmHJ+J1SpRUZ1oEeBVa4jSyiQo5uHZidLLUwUcjUOmNYetG
         SrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jVsBIt3UuAl5LSk1ZswruBzMsu6E7SfYBM1V38VtIU4=;
        b=zKe4MPAI4SNHcReU/koblj8sCQaKrzxoniuSv52tHpce2G+CDBJMCkjMPAMS3w9s/U
         8v+gZQ4xqPVcitdLmCSOgAPn/e6BGWVCrY98wRG2CV/RHLkmlDtdrG0bRyWxeXlvn7xM
         aP9vA84GSJa/e20m+bP0iZlAwipVHT4VcqV6wD+IdYwUmKt6zvZIECvuEYKb/tx+GdRu
         QEBD49fQPJyGyFXDU1hRgqA+qjCz8IK/degbm2+h2DNw6u133MfxbTPCtC2F4wSjV/BG
         EYKJxzs2QRLdzGoqYVfEg8yESlREk6C2WbnCEkuspD9aLFlGNFFAXTf+R7iy3MX52LHy
         /Txg==
X-Gm-Message-State: AOAM531B40ajXnb+KRCKH/CxsuGJvrf99TbBf1ftiMwlyKGOFNU82n9X
        cQdFYRr1SDydRFm5qf1Wq5fI4qVlihs=
X-Google-Smtp-Source: ABdhPJzJK2RzgHJpAbZDBEyFi8YcO7I315u1pDWbM5pgtzLnB9aUvShegG+NTwUBHvjFFQPlnkNgug==
X-Received: by 2002:a05:6808:300a:b0:2f9:4722:fffc with SMTP id ay10-20020a056808300a00b002f94722fffcmr17628097oib.31.1651066911902;
        Wed, 27 Apr 2022 06:41:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d3-20020a9d2903000000b005cda765f578sm5878041otb.0.2022.04.27.06.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 06:41:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f155e829-3418-379d-760e-77cf70cb34e9@roeck-us.net>
Date:   Wed, 27 Apr 2022 06:41:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/4] hwmon: (asus-ec-sensors) introduce ec_board_info
 struct for board data
Content-Language: en-US
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220426092340.495704-1-eugene.shalygin@gmail.com>
 <20220426092340.495704-2-eugene.shalygin@gmail.com>
 <20220426151656.GA3119637@roeck-us.net>
 <CAB95QASxuS=RDN6MRJ89O0pSpqQSaWFQVeyedGyda01FGtR7GQ@mail.gmail.com>
 <6d69fb63-a84f-31e5-0a88-4a154e290573@roeck-us.net>
 <CAB95QARDq1Tr64dvPVemXHRNyu=T5P7LJ_DUn7sdHauUB6daaw@mail.gmail.com>
 <8a8579df-1fd6-32bb-3e27-297efefe28c4@roeck-us.net>
 <CAB95QAQPRVO=Cd27QthFZ_fDTr=Nvzqzrh0QnFs5475yTx+qJw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAB95QAQPRVO=Cd27QthFZ_fDTr=Nvzqzrh0QnFs5475yTx+qJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 06:34, Eugene Shalygin wrote:
> Maybe I'd better leave a comment why module_platform_driver_probe() is
> used as opposed to module_platform_driver()? I think that one would be
> more straightforward...
> 

You are correct, that is easier. I thought that it calls the probe
function directly and bypasses the normal probe handling, but that
is not the case. Sorry for the noise.

Guenter
