Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED71542502
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbiFHC4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443669AbiFHCxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 22:53:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F05F1AB610
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 17:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654647807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=heXsD028htaJL34qTH2KR7HknWXjuOe5IQ5XBb4j4Eo=;
        b=Wc0SG9jAjdmAeSSAa1con/Gwvc6ZtrXMtkDaRcLQvQehG0xEwilTJqeVKMq/eAXCu/5Wa8
        Re/yaIlsi8Vll1KEsMUVP7ZHsHht/z9VlVGeSQVW2E/liYFN8qmWAeOLIZoLTA69L11PY1
        eyuWuGkZaASmM41kpKJKIodueSWF/As=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-dLSc1W27PMiT0ESy38G00A-1; Tue, 07 Jun 2022 20:23:26 -0400
X-MC-Unique: dLSc1W27PMiT0ESy38G00A-1
Received: by mail-qv1-f70.google.com with SMTP id dg8-20020a056214084800b004645cecc145so11967917qvb.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 17:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=heXsD028htaJL34qTH2KR7HknWXjuOe5IQ5XBb4j4Eo=;
        b=4BF+bPAN4kW2R8TrDziZVNuH+qiRTkje0M92CEfY17vBAGKIYZe7uXqEbnUCX3Ukda
         0C4fnVZT+xPJppatnMkAS9ANZ8yh2mFmegyGZA7LvZ3Oii8eKyJHgarZLxBCXcBzsJ2Q
         sVoZfMofgv7B52EiVCp7sXhImg/BJhE0EP5PXnHlP4OuSfPzlVoMP32sZNlpTpG0+MR3
         +jU5GStJEzF1/5Fqj+wsGPPDrKWBTdRfC3lp8odxDSU46Z5bEdpCHrTocP1SEWNpQPIN
         jIhC0WI/weJxn1jEzgeTSMnCVJMQwpAO6Oi8tzVhuV1siesHbaPBN2qKQh0ETBPLTmLo
         VGxw==
X-Gm-Message-State: AOAM531fUWgZkxOueCIJUXVeooMWnbwDmeXzuDRvtKB4ebUtoNXWVhxy
        nRVOyXAbbJuHbq9BFYIHA9Xy5UHcQi11nsvE6HrMMxgejB4Ricay7kt417gh7J6ozQtaU2pQurh
        4vLWobmPtdrYGjkqqs+PnH0uS
X-Received: by 2002:ac8:5bcb:0:b0:304:ff2f:459f with SMTP id b11-20020ac85bcb000000b00304ff2f459fmr2348848qtb.545.1654647805520;
        Tue, 07 Jun 2022 17:23:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIHuSZClxr2yO8JHNfpgL49r9yYKKOsVIAjccwnE/IxiAhcJzAOFAxsOfHcFFuyKjCzc1zlg==
X-Received: by 2002:ac8:5bcb:0:b0:304:ff2f:459f with SMTP id b11-20020ac85bcb000000b00304ff2f459fmr2348836qtb.545.1654647805327;
        Tue, 07 Jun 2022 17:23:25 -0700 (PDT)
Received: from [192.168.98.18] ([107.12.98.143])
        by smtp.gmail.com with ESMTPSA id i8-20020a05620a404800b006a69aba9f19sm12042819qko.80.2022.06.07.17.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 17:23:24 -0700 (PDT)
Message-ID: <8b94a750-dc64-d689-0553-eba55a51a484@redhat.com>
Date:   Tue, 7 Jun 2022 20:23:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [net-next 1/2] bonding: netlink error message support for options
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <cover.1654528729.git.jtoppins@redhat.com>
 <ac422216e35732c59ef8ca543fb4b381655da2bf.1654528729.git.jtoppins@redhat.com>
 <20220607171949.764e3286@kernel.org>
From:   Jonathan Toppins <jtoppins@redhat.com>
In-Reply-To: <20220607171949.764e3286@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/22 20:19, Jakub Kicinski wrote:
> On Mon,  6 Jun 2022 11:26:52 -0400 Jonathan Toppins wrote:
>> Add support for reporting errors via extack in both bond_newlink
>> and bond_changelink.
>>
>> Instead of having to look in the kernel log for why an option was not
>> correct just report the error to the user via the extack variable.
>>
>> What is currently reported today:
>>    ip link add bond0 type bond
>>    ip link set bond0 up
>>    ip link set bond0 type bond mode 4
>>   RTNETLINK answers: Device or resource busy
>>
>> After this change:
>>    ip link add bond0 type bond
>>    ip link set bond0 up
>>    ip link set bond0 type bond mode 4
>>   Error: unable to set option because the bond is up.
>>
>> Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
>> ---
>>
>> Notes:
>>      Removed the printf support and just added static messages for various
>>      error events.
> 
> Thanks! nit, missing kdoc:
> 
> drivers/net/bonding/bond_options.c:729: warning: Function parameter or member 'bad_attr' not described in '__bond_opt_set'
> drivers/net/bonding/bond_options.c:729: warning: Function parameter or member 'extack' not described in '__bond_opt_set'
> 

Thanks, will post a v2 tomorrow. What tool was used to generate the 
errors? sparse? checkpatch reported zero errors.

