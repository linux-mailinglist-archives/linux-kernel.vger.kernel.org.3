Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F79751FB1B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbiEILRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbiEILRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:17:18 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C0A1BD72B;
        Mon,  9 May 2022 04:13:22 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id e2so18928979wrh.7;
        Mon, 09 May 2022 04:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T4LAt8Asg06X7YXFQcHI6MAN9LrQ6fkQ8tBm57S4Ejs=;
        b=QxRjhP3Zu9qW5iEu+QAg4OH43uvDv/9AMvL1ZkROknil0P7diJha+5uNWGG3Gl1AZR
         CrB81dDwVTaHLLA3aspMk+Ws6jSA1FOmkdrepNfsPdCWv5fVhGv0mA4pC9YUclZxxB/e
         L+mqvOCLfimz1jv7YxqE+GHiLBeDvxDKrBkswuGEV1MltKEQ2VqsxBCiLole3JLkMwtN
         vaFqEnirBEp9fO9PYPOiAIsdq5MDb+CxIIRHyhAI6Y3zfJvMP3j+0Y9y0es0MjLGf8vb
         /utBvO5rkMBIm3FGEkXfJXZEhmHrBfDcLhSte/4XBQ+IA5VbLjpfehGpd8QQ7wpjbuJR
         RGeg==
X-Gm-Message-State: AOAM5325Uuib37LxqnYT2AKFGa962cijG/lZIY72WqgsXEoOMphSxW38
        4fz8selY1nJ1pU2K8ZsmeHo+/f4qGgzrM0No
X-Google-Smtp-Source: ABdhPJxDND7vbdlA5MD/2X7uKYc0iSgTVYyTgNvpg/WHGyKwyWq3RS3N3WJGNl+Vyvm3K1dxidaE6Q==
X-Received: by 2002:a5d:5960:0:b0:20c:5a12:20ed with SMTP id e32-20020a5d5960000000b0020c5a1220edmr13399839wri.303.1652094800996;
        Mon, 09 May 2022 04:13:20 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id j14-20020adfe50e000000b0020c6a524fd5sm12439829wrm.99.2022.05.09.04.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 04:13:20 -0700 (PDT)
Message-ID: <b42bc4d1-cc9d-d115-c981-aaa053bdc59f@kernel.org>
Date:   Mon, 9 May 2022 13:13:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/3] tty: n_gsm: fix mux activation issues in gsm_config()
Content-Language: en-US
To:     "Starke, Daniel" <daniel.starke@siemens.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <DB9PR10MB588149B7E9A31D3476762776E0C69@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <DB9PR10MB588149B7E9A31D3476762776E0C69@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09. 05. 22, 13:03, Starke, Daniel wrote:
>>>    static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
>>>    {
>>> +	int ret = 0;
>>
>> Why is the initialization needed? You can as well declare the variable only inside the if below.
> 
> You are right, this was unneeded. But this patch was already included in
> the tty-linus branch. Shall I resubmit it nevertheless?

In that case, you can only send a fixup patch...

thanks,
-- 
js
suse labs
