Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D2452D700
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbiESPIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240634AbiESPI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:08:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE18ED726
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:08:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w4so7562676wrg.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2w3QCxHuyZHZWTrIBErbgmf9ZNgUm4m0vFJEtVVQ6So=;
        b=L4h1ArFVfv0MGM4j7EKy4nHdFCAxWnLl1wVyU+zrGpShZrQNffuKoOaMSWlYep9Nse
         Q+zzsTUxyYjiptKsGiFmn6ZC1VhT3n0Pib8DmO252qsfnb+IsZ25yHaGnVoAzr1LZ+gL
         YEe1hWoqDl4iR6uDmyhg7TP6Vl2TLOgYOBnaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2w3QCxHuyZHZWTrIBErbgmf9ZNgUm4m0vFJEtVVQ6So=;
        b=6zu3zOLMS+3l7RlD5op8YmfRgPUMPFJ9ZS50Z6EPuJ8i8Zhah1VcxrH20dkrVNKtTu
         JHVgYSg+B3Y8QbHBOfPfyHIfonLKld/aQm+AH+HWN07p2UhgAZIiSjN5bH0zKR6WtahT
         wCv92SAaP5JQM4xJxHORHG/KTIIjWTfHJ4GiTibOAD3DhCgUglCVygerF1jHVhU4yOBc
         x0GXGBYpVSdoASxhvHEF6Mk3GjdmKoKodUt2wPRZ0HXUQbRuHFGVc+rh2RKyjBmr+lVh
         88zhr1Qb3TSfH3u51wpxmAKIgkBGfb5wg89dkddFVe+J0C3lVDlaahQ6Hjm9pKAjcD8n
         nZ6g==
X-Gm-Message-State: AOAM530XgfMXfssU3twas35HifTbQo5oN94wiJjq/3HV2DbZlxNbe1/F
        nqYlmQnF0o1Gju1M7iy9/ruMAA==
X-Google-Smtp-Source: ABdhPJwuUYlV9tPCvSr9RmR+k10qhzgtzq6bt9RQl5qDKSToq184g8gGdaOJlNCGMRrO4D4P7S7AuQ==
X-Received: by 2002:a05:6000:1688:b0:20d:a533:fc5 with SMTP id y8-20020a056000168800b0020da5330fc5mr4442241wrd.338.1652972886591;
        Thu, 19 May 2022 08:08:06 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::4:c1eb])
        by smtp.gmail.com with ESMTPSA id w6-20020a05600c038600b00397335cf750sm1244435wmd.47.2022.05.19.08.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 08:08:05 -0700 (PDT)
Date:   Thu, 19 May 2022 16:08:04 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        kernel-team@fb.com
Subject: Re: [RFC PATCH] printk: console: Allow each console to have its own
 loglevel
Message-ID: <YoZdVCfK4T8Ts2oS@chrisdown.name>
References: <YoUBh5BSsURDO71Z@chrisdown.name>
 <YoUR6RlzkCNG7BU0@kroah.com>
 <YoVM+KbdyJm8RSSr@chrisdown.name>
 <YoVO23+fvsNPnpKh@kroah.com>
 <YoVWpZKHD7aec0CJ@chrisdown.name>
 <YoXsAkUgzIjJR90W@kroah.com>
 <YoZQQwtG12Ypr2IC@chrisdown.name>
 <YoZVvA5FP4wFLSH9@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YoZVvA5FP4wFLSH9@kroah.com>
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman writes:
>>  struct console {
>>  	char	name[16];
>>  	void	(*write)(struct console *, const char *, unsigned);
>> @@ -179,9 +173,11 @@ struct console {
>>  	void	*data;
>>  	struct	 console *next;
>>  	int	level;
>> -	struct	device classdev;
>> +	struct	device *classdev;
>
>Ick, no, keep the real structure here.  It can properly handle the
>reference counting for the object.  Just correctly clean up in the
>release function, not anywhere else.

Sorry, I'm getting more and more confused about what you're asking me to do, 
and less and less clear on the rationale.

Can you please clarify what "correctly cleaning up" would mean for a 
non-pointer `struct device'?

Is your concern that...

     register_console(c)
         device_initialize(c->d)
         device_add(c->d)
     unregister_console(c)
         device_unregister(c->d)      console_classdev_release(c->d)
     register_console(c)
         device_initialize(c->d)  <-- classdev was not previously zeroed out
				     in console_classdev_release() and bad 
				     things may happen

If that's not the point, I could really use some clarification about what 
"correctly cleaning up" means for a non-pointer `struct device' :-)
