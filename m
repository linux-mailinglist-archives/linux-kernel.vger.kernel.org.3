Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2385451DA6A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442043AbiEFOXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243903AbiEFOXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:23:46 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 360FB68FAC
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 07:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651846800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Doqk7KhGyk0EBDANXsBv2tmfDD+hT1qhKftthfkS7cs=;
        b=dVyvu8tf/ND4M/FbzZX4900Wei1CVqLT33jOFyc08Qw1jpdYDxyWVIr07m6iE7+vuYPJDw
        iE/hnzdH6woeBOMPbY0uDb7XDH5m0ELdG/P8PSVcbeS8ycdPJR5bykbk9le+4XZdrnEsgZ
        tM+jIvPkvfc/6nJUsh+/850f0LdrApc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-0u44VB8sPaqVXogqLZwSRw-1; Fri, 06 May 2022 10:19:59 -0400
X-MC-Unique: 0u44VB8sPaqVXogqLZwSRw-1
Received: by mail-ed1-f69.google.com with SMTP id cf16-20020a0564020b9000b00425d543c75dso4104653edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 07:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Doqk7KhGyk0EBDANXsBv2tmfDD+hT1qhKftthfkS7cs=;
        b=xeDoZT7jeFlG9/apMQwaWvZPWbg4li8ZAK4pNYxn0VqdE64ml+0fkrTicAK9SkawGj
         MVrWP0GCWACExSnazIeWWIf5NRVH9GzTKocsAy9HsyhTY7f7cdlz0Q6F4QI2f4LnZHuR
         6kWBjg3I6VC1gk8cGGoo00fZOGL2MrWuMBHIQQUwz99wHsZb6Sx4Oh1YQbOLFFU8e4oy
         k9X8crRHNiYNgmup79bEQfAUIf9DBTIfCO5EVwAzkLrRhSRVZcL0sSu1gRg6POD8Isls
         24jKAeFFRcm517OAoPEqOHlMN3JVFWQNHOKCNq+gny6g13heKwAKMci10/n7Ls59XWXL
         RElg==
X-Gm-Message-State: AOAM533Cgqe3JF3lOtH1UGaUTt0iGQ/t65WUI0D5hCZuDf0glayemkUQ
        b81k8livCvZZ5QDHApv7xiiKfbUX8FFM7v5ITh3Nk+Y0XbxLGYVBke/E7fVnQYFXS4OFbqFD8Rc
        M9R/NIExmfImXBdPcjcAZvKJJ
X-Received: by 2002:a17:906:4fc4:b0:6da:b4c6:fadb with SMTP id i4-20020a1709064fc400b006dab4c6fadbmr3276505ejw.282.1651846797997;
        Fri, 06 May 2022 07:19:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6Rvy2dRSgaYN9vdv1LxcPQ7MR9GWZ/uPHsWuJrOXf9xFz9COe4Lt6mC4M6ylDEUxRJ5N9zA==
X-Received: by 2002:a17:906:4fc4:b0:6da:b4c6:fadb with SMTP id i4-20020a1709064fc400b006dab4c6fadbmr3276491ejw.282.1651846797855;
        Fri, 06 May 2022 07:19:57 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id r4-20020aa7d144000000b0042617ba63a4sm2300790edo.46.2022.05.06.07.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 07:19:57 -0700 (PDT)
Message-ID: <b18234d7-a1f4-d5a4-e59b-f5439c38c2d0@redhat.com>
Date:   Fri, 6 May 2022 16:19:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 00/10] Introduce In Field Scan driver
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, markgross@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        jithu.joseph@intel.com, ashok.raj@intel.com, rostedt@goodmis.org,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com
References: <20220422200219.2843823-1-tony.luck@intel.com>
 <20220428153849.295779-1-tony.luck@intel.com>
 <13054c5c-ed48-b7a2-a800-25b9b1b1ab0d@redhat.com> <YnFK+gXFx0jQB1dz@zn.tnic>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YnFK+gXFx0jQB1dz@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/3/22 17:32, Borislav Petkov wrote:
> On Mon, May 02, 2022 at 05:15:39PM +0200, Hans de Goede wrote:
>> I'm fine with this entire series getting merged through the TIP
>> tree,
> 
> Hmm, so looking at the diffstat - the majority of that is
> drivers/platform/x86/ so I guess your tree would be better suited for
> it...

Ok, that also works for me and I see that the few arch/x86 already have
Ack-s / Reviewed-by-s from you / tglx .

I'll give it some more time for review for v6 and then pick up v6
(or v7 if review leads to more changes).

Regards,

Hans

