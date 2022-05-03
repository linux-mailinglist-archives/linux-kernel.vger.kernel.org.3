Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD8F518EE7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbiECUf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbiECUf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:35:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A8222E0AE
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 13:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651609905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=syat7YMhuZsVmWB5UU3BjXsEYQfynCb0liib1ovne74=;
        b=Z+ZYmM85F3CgtrikbE2tDyIwF4JyZQC2/QRMlK7jjViuKAFUu4x/BlyAYyz3sWksp1VHYB
        BEsNLmqQ9Dt/O2ccZsxDRB60EAzVGPQccHmt3k9YcNsv/VL8NUU1MKAxmlCtWXHf8cEMwB
        6EGDP4KrXk9tbqu4VsGB17GZp1DAFqw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-NPW8qe14MHO1H1xVrfqppA-1; Tue, 03 May 2022 16:10:36 -0400
X-MC-Unique: NPW8qe14MHO1H1xVrfqppA-1
Received: by mail-wr1-f71.google.com with SMTP id p18-20020adf9592000000b00207bc12decbso6726654wrp.21
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 13:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=syat7YMhuZsVmWB5UU3BjXsEYQfynCb0liib1ovne74=;
        b=Nsw3MCHKD2deLtumRuL4IAO8pdnP+cH3jKXqzUvnm9EC1Fann7yX5WQRxEOPZ4nWtV
         ebtltOAfFzMgKRSAlf2JzeaJC1/oJyVz9J5jEHaEYVVie+mdzviwsyAOOh9IGbRGGXCC
         jHP777hObeZxJtO/Swqvk0PODWHc80+b7FlQA/WQsT96NbnR1ZUoRdLSylEiV4+IGMPB
         DaVAfCsZC2jRKsotcZG0c9miE2D+V52Ciy6RmDpXz47k++cN5lXzpgjSMcSZTfSghk5e
         vrNYdgZuQU+7cOI5L8cXPDV2CBGEkcSOND1fkIybcuq/FGZBEhB/39AG/wHEwLVMWK3G
         4kjw==
X-Gm-Message-State: AOAM533SU9dz9JUevclZ+6AoZ9eP2arM/xqY4WE87s65SLN4BP1FI/0d
        E9Eoc6ordwUaNp+7LyqGplkHBlg4yHTVyKmVToBUQlGzlsMpRQ0UI1PO3aDcOMf0cGW8xs8HwJJ
        KS+UwtbDz5a6GEvWNbpyYIbt3
X-Received: by 2002:a5d:64c1:0:b0:20c:6ff9:3a61 with SMTP id f1-20020a5d64c1000000b0020c6ff93a61mr5677532wri.709.1651608634855;
        Tue, 03 May 2022 13:10:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxplYC3nN3AU/qbF7B/q23G6fIYuctdgY1cqefQA5M02QsqpsEPVQ8d3IifAGDcAdL4PT0raA==
X-Received: by 2002:a5d:64c1:0:b0:20c:6ff9:3a61 with SMTP id f1-20020a5d64c1000000b0020c6ff93a61mr5677518wri.709.1651608634651;
        Tue, 03 May 2022 13:10:34 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l3-20020adfbd83000000b0020aca418f26sm10156318wrh.1.2022.05.03.13.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 13:10:34 -0700 (PDT)
Message-ID: <9907fa2f-807d-f07c-152b-e09d35afa332@redhat.com>
Date:   Tue, 3 May 2022 22:10:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fbdev: Use helper to get fb_info in all file operations
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Junxiao Chang <junxiao.chang@intel.com>,
        dri-devel@lists.freedesktop.org, Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20220503164616.663796-1-javierm@redhat.com>
 <YnFi2nrK0I7893S2@ravnborg.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YnFi2nrK0I7893S2@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sam,

On 5/3/22 19:14, Sam Ravnborg wrote:
> Hi Javier,
> 

[snip]

>>  
>>  int fb_deferred_io_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>>  {
>> -	struct fb_info *info = file->private_data;
>> +	struct fb_info *info = fb_file_fb_info(file->private_data);
> This looks wrong. I assume you wanted to write:
>> +	struct fb_info *info = fb_file_fb_info(file);

Right I did. Thanks for pointing out.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

