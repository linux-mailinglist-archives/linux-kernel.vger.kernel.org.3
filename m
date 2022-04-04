Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBFA4F16D3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376999AbiDDOSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbiDDOSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:18:32 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596AF3B033
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:16:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bh17so20244760ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 07:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Yrk+LsPAZj6NgBL9bPWTDL2JqqAIRaC05jfjs6HeV6M=;
        b=C0CQSnrkT94LDeC4aymHxJuLO2rX5kVxd1bwalPdQCHCPhlzw9BgtNCNqGvLj/5NzH
         +kmPzX98/bS8hRL1+b36hhL1ZLFlcZSqIzfQMQXlaWyMdgFmSsh9Ldf3i2QFiU5DgQOW
         fQnguE6E2ed4f3QSkRHe613J4wOhuVpuCgoj8YyalA5UcKmsgod7XbwQ+CLmyCvrMSrv
         khfEP4OlSKcps0B1Vfh70wLkcguDLSLhp9Zc72rDKGCs6sSLadBxPeoUs+tt+dmLS/rn
         0ecsQV34R94NtDo1QbGSK6Uob16u/gBZHB1OpULpjjj1SZ/aZqA6CVHTNlV9v0+PwFh+
         l+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Yrk+LsPAZj6NgBL9bPWTDL2JqqAIRaC05jfjs6HeV6M=;
        b=F8pV+DCi0IJKIgc8+Zpq73YvOrhkHjWmVYP14m3gxi2dh4gNafpyDJ1QCHFNWzwiNx
         JbBGah8OzE76MuXRv7+7MWJLXcZKUrNNUa9jFrEb2XuTVNeZ9nZuyS0Bo6uSenSGF9sj
         kR4bO0TrjMGgPJ3vxEwpeg9DKS5aJGvYJhC+xX0Rd3bl50NrgaQyIpqWIcXLhDdacor1
         jzvHAFVeeXrVotMvClO2yPoS+pp79T8ODsJ9LI3XanIzz360M+4kQqxUmVCTl0Jqw3rT
         drvNxvPRw2YN5DqpPeAvw2XuqHz8dqAIA2WyQtZ7BPlKGxC1KrmNyo3C9BfN1YTIbTmP
         S0FQ==
X-Gm-Message-State: AOAM530DlA3rLP3xOrTXfCVI9M1u7h9WIGhWmXZ4ZzwoqZNxcc0FyQCt
        /0wmyRqazZjpuaHNqVx2DMg=
X-Google-Smtp-Source: ABdhPJwvxYyF0JUDpmRlQHyz90MqCDt9VyxoPybNjJQvz6+gMQG4EbL38QpAT2rrxotiAAc0RzaZoA==
X-Received: by 2002:a17:907:7e94:b0:6e4:9d72:a784 with SMTP id qb20-20020a1709077e9400b006e49d72a784mr260209ejc.346.1649081792880;
        Mon, 04 Apr 2022 07:16:32 -0700 (PDT)
Received: from [192.168.0.253] (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id ga10-20020a1709070c0a00b006dfc7c089f7sm4389965ejc.1.2022.04.04.07.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 07:16:32 -0700 (PDT)
Message-ID: <66efc2d7-ec85-25af-1499-0dce2a09c3cd@gmail.com>
Date:   Mon, 4 Apr 2022 16:16:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: staging: r8188eu: how to handle nested mutex under spinlock
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <356c24cf-625b-eea2-2c04-ce132d881cac@gmail.com>
 <bf1137fa-5051-a834-0c1f-042c5a8074a3@gmail.com> <1858641.taCxCBeP46@leap>
 <2366209.jE0xQCEvom@leap> <617af7b6-eeac-372a-7bbb-828db11a2aa9@gmail.com>
 <20220404133312.GC3293@kadam>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20220404133312.GC3293@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 15:33, Dan Carpenter wrote:
> On Sun, Apr 03, 2022 at 02:18:04PM +0200, Michael Straube wrote:
>> On 4/3/22 14:10, Fabio M. De Francesco wrote:
>>> For a list of all the paths to a given function you may use Smatch:
>>>
>>> ./smatch/smatch_data/db/smdb.py ips_leave
>>>
>>> or
>>>
>>> ./smatch/smatch_data/db/smdb.py call_tree ips_leave
>>>
>>> But perhaps you already know how to do it.
>>
>> Yes, but thank you anyway. :)
>>
> 
> My email (gmail account) has been so weird recently.  I don't know why
> I'm not getting Fabio's emails...  Presumably they will show up in a few
> days.
> 
> The other command to use is:
> 
> $ ./smatch/smatch_data/db/smdb.py preempt ips_leave
> rtw_set_802_11_disassociate() <- disables preempt
> -> _rtw_pwr_wakeup()
>     -> LeaveAllPowerSaveMode()
>        -> ips_leave()
> 
> I save that to a file, open it with with vim and run a vim function
> `hall` (for highlight all) from my .vimrc file.
> 
> " Use :hall to highlight all the words in a file (for debugging sleeping bugs)
> function HLall()
>    let a=[]
>    %s/\w\+/\=add(a, submatch(0))/gn
>    let @/ = join(a, "\\|")
> endfunction
> cnoreabbrev hall call HLall() <CR>:set hls<CR>
> 
> That highlights all the functions is the call tree, then I use cscope to
> jump to rtw_set_802_11_disassociate and follow the highlighted functions
> to ips_leave().

Thank you for this hint Dan. :)

thanks,
Michael

