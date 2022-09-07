Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3155B0D34
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 21:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiIGT1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 15:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiIGT1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 15:27:38 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B425B9C23C;
        Wed,  7 Sep 2022 12:27:37 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id z9-20020a17090a468900b001ffff693b27so14448845pjf.2;
        Wed, 07 Sep 2022 12:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+cTrbJ2TImjXO9+/sDbso3elnuRkmLBrBB8v3kbBqJw=;
        b=xPHocj+VEjtadV0gVUm+FUzmkZaIcXwCKLdfuLknWAMgUo4xam7EnsG2AgOMhgF2CD
         qfqpYBdAMjRdAJAnnMVe6AwXRNR+ifSMpDxaXybR4Or5zeSzrm5gyHqAxh4gmbBBt1Ij
         KDU7lT9jN1Dc1GzvmQPh/IfCNFqYC5w3OZtnzyBnQ+j+1AhueGb8EJVLVcMihwPdvqU7
         xckG+EBri6CDc1kFaKN8Vy12O5CcrQay0Coh5fdR7dJAAS36m+2O5d8SJdsQ71W4xuuJ
         n/upDCDPA8R5PT34s140c593WrHQtyKPSFdBbfP1ioJfhXpC2/Q+dyyPQ+xyNPSNXMqT
         JjrA==
X-Gm-Message-State: ACgBeo1J9OVEwEvAxGsuQkfAABcK9+Eu1PdEvTHKnrC0wHY2F970Urp5
        1pkijz+TiPuhG/lvxXoVuxQDSVZGHz4=
X-Google-Smtp-Source: AA6agR4viDHpwIxrS1F4soYchr2Lep+3b51frp7/TgfneVVxFVli5I3nJmz9e8JJ64AgtxVJMy4+jQ==
X-Received: by 2002:a17:902:bd08:b0:16d:4230:cb45 with SMTP id p8-20020a170902bd0800b0016d4230cb45mr5460043pls.59.1662578857142;
        Wed, 07 Sep 2022 12:27:37 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:899e:cff7:8f51:a7ba? ([2620:15c:211:201:899e:cff7:8f51:a7ba])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902ecc200b00177e4a26d9fsm1566488plh.204.2022.09.07.12.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 12:27:36 -0700 (PDT)
Message-ID: <60870376-3518-896b-7a6b-a4b9ea05264f@acm.org>
Date:   Wed, 7 Sep 2022 12:27:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/1] tracing: Fix compile error in trace_array calls
 when TRACING is disabled
Content-Language: en-US
To:     Arun Easi <aeasi@marvell.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Petersen <martin.petersen@oracle.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, GR-QLogic-Storage-Upstream@marvell.com
References: <20220907185745.14382-1-aeasi@marvell.com>
 <20220907185745.14382-2-aeasi@marvell.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220907185745.14382-2-aeasi@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/22 11:57, Arun Easi wrote:
> +#else	/* CONFIG_TRACING */
> +static inline int register_ftrace_export(struct trace_export *export)
> +{
> +	return -EINVAL;
> +}
> +static inline int unregister_ftrace_export(struct trace_export *export)
> +{
> +	return 0;
> +}

Isn't it recommended to leave a blank line between function definitions?

> +static inline int
> +trace_array_printk(struct trace_array *tr, unsigned long ip,
> +		       const char *fmt, ...)

This is not the recommended way to format a function definition. 
Consider running git clang-format HEAD^.

> +static inline struct trace_array *
> +trace_array_get_by_name(const char *name)

Same comment here.

Thanks,

Bart.
