Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4821D4BA4A9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242412AbiBQPmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:42:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbiBQPmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:42:17 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58F014091
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:42:03 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id h125so5362647pgc.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yVhi1vrXuuKJzKMS2sNWbuq/VeCq4utS+Vch13kpKEc=;
        b=BmDtYDzJKXDcv8FzzThwHh1+iARxAaSrnR5xDc0jJVCXZLpzzSPjtdnyGrdVBAl/8O
         0+9VvvmbUqOHNRGMgF/8+mSUY36IBvrtbIcOVxPwk/xZa9yW+e+lX67tzpT+8A5TftYU
         bF0JC6mbzl69qEb329u3Lo6No2hffFEcw6y3AyK4eYZS12q3rI9xq9Nvg4nM3AmAbvjK
         WjqwdqyXTXzPnDQfSwLlHxSuLCq5aTL3xGtoe0UegbJkh8uDat+byOzTY+922IK74YH5
         IcqTFzpp90JR08t53vqx2gcbUQaI8fzAlI2jzSGZeis52dIyvLXJVQe8UxJu/evhpp57
         KemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yVhi1vrXuuKJzKMS2sNWbuq/VeCq4utS+Vch13kpKEc=;
        b=xCYESIad4nvHQoWiMcqijv7SZ22utzGgtkdD6TO6s1HsuxNjzj3EyILOhfcosSq+Vq
         FCMqtvYxTKcU1a7q0/Jwj1l3WLBwMxAinjOA+N6blPtibMeRnqe7xUB24Yx0TGYShVjd
         epIZXkW1nYDvtC939YJXFyWWlSTLqYdWr7awwM7+9kz9mwKuZ+KikKuCIps68qf1SItb
         Z1du+wQvMrgP/CRzKGH5xaJ9n/qT8uXWTMn/Rod0XJjeFbQqqC9HM7jwXKuEptYzU1YR
         IBRAHD6RvAVpJFiq1rUAsjRQT44VnxJ9rYq7o7B656+Zoggm5CP4InSBkVb715Klv8ku
         /KTg==
X-Gm-Message-State: AOAM532ahMiAiMC9QAN8phVdvjpM4XDd9aZK2HndFmCmp0jIKsGpX7PC
        qtmWMlLIQALVYxmZa1cizHk=
X-Google-Smtp-Source: ABdhPJycOJoy3WaWAE95XhqQ/wFO/elcT3zeYJT7ZypumKHHdW5eurfCSvZ1xV4Rn57tW9O/6M//Mg==
X-Received: by 2002:a05:6a00:9a9:b0:4ca:c2f1:c685 with SMTP id u41-20020a056a0009a900b004cac2f1c685mr3612023pfg.12.1645112523183;
        Thu, 17 Feb 2022 07:42:03 -0800 (PST)
Received: from mi-HP-ProDesk-600-G5-PCI-MT.xiaomi.com ([43.224.245.244])
        by smtp.gmail.com with ESMTPSA id y7sm11203604pfa.213.2022.02.17.07.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 07:42:02 -0800 (PST)
From:   chenguanyou <chenguanyou9338@gmail.com>
X-Google-Original-From: chenguanyou <chenguanyou@xiaomi.com>
To:     longman@redhat.com
Cc:     chenguanyou9338@gmail.com, dave@stgolabs.net,
        gregkh@linuxfoundation.org, hdanton@sina.com, jaegeuk@google.com,
        linux-kernel@vger.kernel.org, mazhenhua@xiaomi.com,
        mingo@redhat.com, peterz@infradead.org, quic_aiquny@quicinc.com,
        will@kernel.org
Subject: Re:[PATCH v5] locking/rwsem: Make handoff bit handling more consistent
Date:   Thu, 17 Feb 2022 23:41:54 +0800
Message-Id: <20220217154154.6030-1-chenguanyou@xiaomi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cb03cbe5-0357-144d-0660-3ebc50c0245a@redhat.com>
References: <cb03cbe5-0357-144d-0660-3ebc50c0245a@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Hi Waiman, Greg,
>>>>> This patch has been merged in branch linux-5.16.y.
>>>>> Can we take it to the linux-5.10.y LTS version?
>>>> What is "this patch"?
>>> commit d257cc8cb8d5355ffc43a96bab94db7b5a324803 ("locking/rwsem: Make handoff bit handling more consistent")
>> Have you tested it on the 5.10.y branch to verify it actually works
>> properly for you?
>>
>> If so, please provide a working backport to the stable list, as it does
>> not apply cleanly as-is.
>>
>> thanks,
>>
>> greg k-h
>>
> I have attached the 5.10.y backport of commit 
> d257cc8cb8d5355ffc43a96bab94db7b5a324803 ("locking/rwsem: Make handoff 
> bit handling more consistent"). I also include a backport of commit 
> 2f06f702925b512a95b95dca3855549c047eef58 ("locking/rwsem: Prevent 
> potential lock starvation") which I think may help Jaegeuk. I had run 
> some sanity tests and the backported patches work fine. However, I don't 
> have access to their testing environments to verify if they can fix the 
> problems seem by Chen or Jaegeuk. So please test these patches to see if 
> they can address your problems.

Hi Longman,

I'll do some stability testing on our 5.10 phone.

thanks,
Guanyou.Chen
