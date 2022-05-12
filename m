Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3121B5247D4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351426AbiELIYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237176AbiELIY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:24:27 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03326633B1;
        Thu, 12 May 2022 01:24:26 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q130so5543122ljb.5;
        Thu, 12 May 2022 01:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dp5RjKDsRorlt15Q842QS1oD3zaqmbFzxKTc/+h/+tQ=;
        b=MneGklh48zNq8AAwN3ifgUtyhXr9lX5z/oy2m6O2tLieaDN9QE+UD3cbj/bsLZUqZa
         DBg6dcCXwHX1uivRZQF8U3eNzSq1Rj0c01fLeNNE6Nt6My9U8l8UZamKDZ+5j4LeVNFL
         OiAsbqlMfzpEro0I/bv5Jw/jg7gg4kWIK5B29d1fMMh4YmJJs+uPM/UWHy7L73jAnfL1
         9tgx9SPSIM0cDU4qJuOmj71Hh8eq/jwMXe0wkcF1XIBSTCTa5SUjFewve6xDBBaIfT46
         G14Xxr+ZfnSxKCISOaFW2d2eAEmTCO85yVFmSz0zsHKgDAjFKQtJ8y9BW7GPwXTy3EoJ
         OGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dp5RjKDsRorlt15Q842QS1oD3zaqmbFzxKTc/+h/+tQ=;
        b=nj7gP7bbvSfHbxFpHbrjfJcMpmC5YgWxj7FzN7hrCKqmPXjPZfQD61Jx0fdcDB0d7t
         ArdJoOZVjikgn/FdIX3WFe1l8cUl6RBgn6zkSMylWA9NRMY8juPxN+XcnPJAPRWhfmsa
         m8Q7f4oYg77s93TaNY4Ua8LV4iAX6nFJVRrHgyEXavYNmhfKJMYsL1vliBu8tf4x0t/w
         eQccWhe1Ov7mk7P3nRIcmPQT/C8u8lCBxeHvgDRkthhcsh+jXTWXn/Kp3arsnmgbP9Rx
         V9Osbx6KTOWiDIjW6dVrFKJVETYzxHaNBOhVfqGToRZB/eFCSWe/01bnOvbGmBSHv0rg
         6lSA==
X-Gm-Message-State: AOAM5316d9adEm34j631djJFYbtwOLtyNwqA3dgq4asGU/957hWBn14U
        sZRCkWYcCkg2XOe0/UK5IiMq4n5UxGQ=
X-Google-Smtp-Source: ABdhPJyWBOKLTrjc+R7ofT+rL175Kzj+uFEU5bmAzeiLls7z8qDKjLUGSKaVXf2V9tHgoktYGQFqgQ==
X-Received: by 2002:a2e:bb8e:0:b0:250:76dd:3bd9 with SMTP id y14-20020a2ebb8e000000b0025076dd3bd9mr20340342lje.71.1652343863752;
        Thu, 12 May 2022 01:24:23 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.83.174])
        by smtp.gmail.com with ESMTPSA id u17-20020a05651206d100b00474018dfb76sm673110lff.157.2022.05.12.01.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 01:24:23 -0700 (PDT)
Subject: Re: [PATCH v3 09/23] ata: libahci_platform: Sanity check the DT child
 nodes number
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-10-Sergey.Semin@baikalelectronics.ru>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <42dfc76f-a9d9-8e63-874d-b7459cef326c@gmail.com>
Date:   Thu, 12 May 2022 11:24:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220511231810.4928-10-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/22 2:17 AM, Serge Semin wrote:

> Having greater than (AHCI_MAX_PORTS = 32) ports detected isn't that

   Having greater than AHCI_MAX_PORTS (32) ports detected?

> critical from the further AHCI-platform initialization point of view since
> exceeding the ports upper limit will cause allocating more resources than
> will be used afterwards. But detecting too many child DT-nodes doesn't
> seem right since it's very unlikely to have it on an ordinary platform. In
> accordance with the AHCI specification there can't be more than 32 ports
> implemented at least due to having the CAP.NP field of 4 bits wide and the

   It's 5 bits wide, actually...

> PI register of dword size. Thus if such situation is found the DTB must
> have been corrupted and the data read from it shouldn't be reliable. Let's
> consider that as an erroneous situation and halt further resources
> allocation.
> 
> Note it's logically more correct to have the nports set only after the
> initialization value is checked for being sane. So while at it let's make
> sure nports is assigned with a correct value.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

[...]

MBR, Sergey
