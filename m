Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDFC4C26BD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiBXIzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiBXIzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:55:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C62B169383
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 00:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645692866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YPhCBtbBQg1eNMETiQV7Nct7o+5KyMwoVZErHD9r+9U=;
        b=TOv4DDsOV+z8Zc8zE/pe2e29GhOjlevM8Fqp3zrhgtPHnj1jOqt2IMS85gxNmLj/bFPMV2
        9wUEN38NI/piU8af6vOugUKsEp9aqidVQRTtqCWYGtSxUjb555USLC3op1nmcEuScehQFd
        1i1dfseIKoLZL0NUnpdCxyg6qVVS0mg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-y1nzKvv2MRKNwV4bvGwhPg-1; Thu, 24 Feb 2022 03:54:23 -0500
X-MC-Unique: y1nzKvv2MRKNwV4bvGwhPg-1
Received: by mail-ed1-f70.google.com with SMTP id y13-20020aa7c24d000000b00411925b7829so412810edo.22
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 00:54:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YPhCBtbBQg1eNMETiQV7Nct7o+5KyMwoVZErHD9r+9U=;
        b=L2kKpgaSYpE8OjeR7tw/dA1xemZmYdbEEvoE6Z0bDJ6/4+UpXBnwEnGekx0WG/8jij
         cOxe1gd6XoHE0Zbx9HD8geq7J+gpQe0WzxsPU9WMBWMBfw73aGdhUAvyQPinG/GVp3ea
         XJUrIZauVUd66HTEZcHji49H7sV/w+pcZlvq38Tgu+zsme50D63cE3sHdfXAty9uO01A
         DGtekzlhN+QaQ9mCsNXl8LeMYoFUMFjruV2lY0oyteOv/BdOutL3EsSiaZD58vmEZI49
         +eziHCaA4Gr3Xk4PmrAbxtf9aMrmKtSP2A+gAuo6/tfcnfsi07rD4Z9dFNG66acApSWI
         tgRg==
X-Gm-Message-State: AOAM531YT5O5AeV0tkz1+xNTi8O9p8tl6ocfVBkYwKYnC2Gn2hCZKE50
        6igcXtVqBpzsUwqau3TK8CpTn9aPqZw/bK6z+WUyo4G5wXx+95Iw7rnpmEybqEwjbLoMNi9lwWJ
        mS2RmvKXrQ16IIYnKxjaOJ/wy
X-Received: by 2002:a05:6402:3487:b0:40f:fa53:956c with SMTP id v7-20020a056402348700b0040ffa53956cmr1326316edc.22.1645692861857;
        Thu, 24 Feb 2022 00:54:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyAJnHhz/3Ie6pHX1cwQRRG0ycfTSIdcnjOnWNpyAK0LrQieneEB0VUjawsQUWT/GINhQOCLg==
X-Received: by 2002:a05:6402:3487:b0:40f:fa53:956c with SMTP id v7-20020a056402348700b0040ffa53956cmr1326299edc.22.1645692861647;
        Thu, 24 Feb 2022 00:54:21 -0800 (PST)
Received: from [10.0.0.45] (host-95-232-30-176.retail.telecomitalia.it. [95.232.30.176])
        by smtp.gmail.com with ESMTPSA id d12sm968745edy.17.2022.02.24.00.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 00:54:21 -0800 (PST)
Message-ID: <7b856b70-9da0-823e-163b-63d9157b5873@redhat.com>
Date:   Thu, 24 Feb 2022 09:54:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] tracing: Have traceon and traceoff trigger honor the
 instance
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
References: <20220223223837.14f94ec3@rorschach.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20220223223837.14f94ec3@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 04:38, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> If a trigger is set on an event to disable or enable tracing within an
> instance, then tracing should be disabled or enabled in the instance and
> not at the top level, which is confusing to users.
> 
> Cc: stable@vger.kernel.org
> Fixes: ae63b31e4d0e2 ("tracing: Separate out trace events from global variables")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Tested-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel

