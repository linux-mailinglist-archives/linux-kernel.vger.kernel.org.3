Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB2C4F0951
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 14:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357668AbiDCMV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 08:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbiDCMVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 08:21:55 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729B83467E
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 05:20:01 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id e16so12478865lfc.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 05:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=zbodHHrevjydH+zdP0lL/nnwlQQVq6AdfqnfCx0W7oU=;
        b=UHpjHkiDrYV/NBMUyc1gt5luZX4ad+7i18Zz3kJ/GsF5tO2qtEINyZvbs3zDob86D7
         ATCHqS8X3g7xgOdfEHxR4j2a2D97tcS9/7owd+fqQQOdMajcP9OC4v7ODAQZaseYt3D2
         UCmlB2ILmTQ7ei0QhtadNgNR9zY+gKamkVBTFZysVrUj0CyPUeoHkwnOkVPOHXABrUCV
         9PCVpy4Zrfc9+e955iSSq2nOWi4aI+fql5ouwdqZRyaDzFPecdVUbFNkitC8+qvk2GgZ
         9bAPqcDzYwwD27LSE354DRPDYLSSG9HwzImx5LfPVqMUC60yUGB/wC05ZqGXvchHJzIK
         0BUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=zbodHHrevjydH+zdP0lL/nnwlQQVq6AdfqnfCx0W7oU=;
        b=EVSg3Yt33EQ5Vf2RpCYanwv15kj1+npQ7P7Qk4NGZYhjghiDHuwOzUDslZpA2/SnwO
         EI95nDw9+3mQo9UHzQIjMIi/eJozkkEy/O1RR6YuxoJkKGGNnVOpe9zQBzw4tjfGOyvI
         ouoIozXkY+2USRUDbxl2ebHUcBRjgWn81eDcG8GmUN3ye9JdexGbF/i3FIh5KVmOoVP4
         UvR0kMRZIkfD2PCklVq3fuu9/FcPZCA1rBA2jiGqleBKkpgbCJZLRJqws+8h2GXWD5RL
         E3Y77cMfPMnkA87v0Aj3KMCtNF1Is+tkSNOIjs30HvH2QHr3NWaZf+KfMvTNqAlUB1Ne
         vT8g==
X-Gm-Message-State: AOAM5314J/e4AL8Uy7C8/FeqLW/Ax88McPp5s3BCTb4Efra0/RYLi9LJ
        PRhiRzVQzXPQtL9as2mrlYg=
X-Google-Smtp-Source: ABdhPJwVPiaFOsF8CF+UKJVFczY+Y6vkqwIPieZKR+4654dAF79RQZXMYcm0XT5ySNBn4AAVYu+aoQ==
X-Received: by 2002:a19:6750:0:b0:44a:1fd7:530f with SMTP id e16-20020a196750000000b0044a1fd7530fmr19392379lfj.341.1648988399546;
        Sun, 03 Apr 2022 05:19:59 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.247])
        by smtp.gmail.com with ESMTPSA id c20-20020a196554000000b0044a1181c527sm810298lfj.9.2022.04.03.05.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 05:19:59 -0700 (PDT)
Message-ID: <fd356230-c9b1-2824-d073-83975bd31be9@gmail.com>
Date:   Sun, 3 Apr 2022 15:19:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: staging: r8188eu: how to handle nested mutex under spinlock
Content-Language: en-US
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <356c24cf-625b-eea2-2c04-ce132d881cac@gmail.com>
 <1813843.tdWV9SEqCh@leap> <942bbcb6-725d-9b47-5dfe-f105d30ea6b7@gmail.com>
 <7365301.EvYhyI6sBW@leap> <bf1137fa-5051-a834-0c1f-042c5a8074a3@gmail.com>
 <3fb13fee-a605-7f2e-81ad-45148082a733@gmail.com>
In-Reply-To: <3fb13fee-a605-7f2e-81ad-45148082a733@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/22 14:48, Pavel Skripkin wrote:
> On 4/3/22 14:41, Michael Straube wrote:
>> 
>> Hi Fabio,
>> 
>> wait..
>> 
>> rtw_set_802_11_disassociate() calls rtw_pwr_wakeup() only if
>> check_fwstate(pmlmepriv, _FW_LINKED) is true.
>> 
>> 
>> 	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
>> 		rtw_disassoc_cmd(padapter, 0, true);
>> 		rtw_indicate_disconnect(padapter);
>> 		rtw_free_assoc_resources(padapter, 1);
>> 		rtw_pwr_wakeup(padapter);
>> 	}
>> 
> 
> msleep() cannot be called in atomic context:
> 
> drivers/staging/r8188eu/core/rtw_pwrctrl.c:379
> 
>    	if (pwrpriv->ps_processing) {
>    		while (pwrpriv->ps_processing && rtw_get_passing_time_ms(start) <= 3000)
>    			msleep(10);
>    	}
> 

Hm, just wondering, shouldn't we annotate load from 
pwrpriv->ps_processing with READ_ONCE() inside while loop?

IIUC compiler might want to cache first load into register and we will 
stuck here forever.


Am I missing something?



With regards,
Pavel Skripkin
