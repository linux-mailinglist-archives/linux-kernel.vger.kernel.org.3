Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0454C5A9D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 12:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiB0LRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 06:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiB0LRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 06:17:01 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A70F5D19C
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 03:16:25 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 8so10333195qvf.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 03:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kg1Y0OYIFweQQA42dgS1d9xF+KPKvGQpFgfdMWlumF0=;
        b=Q3w/r3DkeyCryBTFfiYCO/Ii7BMHjgXcrWujB1PodX17e24OIRTZQ7kMYVEdl6gQ0s
         IWYkzo4EkczUIvFybEgY6mu6medwdUSzMYw91P9rZv3kQLOni74REsAC5dNwzjZpwonc
         s48IEq+kcx+9q81cLHHHddXQ+SVlv3M2PjRhtikyRtzAQGBRz52TO3OEalTyEoeiLGTl
         gOSCwI9Vq0MtpSIMnzhoOwSEseYXe2cGVgZJqcNaJggr5m/+aCtSaoBzh1XbSQwFm1zA
         YvUint3pB4SYHoIKUBdC8oIhdOKydYl89mD6Bf3wtWsTrIBYtlz0lvS0phEevYsBUmvc
         ab3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kg1Y0OYIFweQQA42dgS1d9xF+KPKvGQpFgfdMWlumF0=;
        b=lQAjKf8trK79Gu879vLjP9lsKDb22VCZUwubNTn79mvBj0UenRdk7Q9F5/SfFqzrd/
         1o1yCQwasQEOmad5EeWjBJCISMPqxMoIYQWIuab1heflIPxuM9qAwk3x+ngY9jDDy4fe
         uDgdW5TrA3lOJ76jKMCSvI4wNlCvgFrvjwBPM3efIe9YGMs3NHoSrT5hiEZ6z7XbLksl
         19ph4ajUdDkFLysIQgqqxNJpNvBofIJWDrnB1TBLSCuTeVp0Hx4GkhcPGIkk5R8cj7jF
         Jzhv70odtlzvqe5VKvRBKJQkNk3BEIVuaK/9nVGO0gcJQ8VywUDdzBYjhZPouhuFogR2
         xJ9Q==
X-Gm-Message-State: AOAM530YuDV0SNR/GhdxOsyPAaDJrk+ppLD/B9hv+kzKyzQy/1k+41Wn
        vQp+pQnFoUbGLFiDWArUZL7P2V5yxaI=
X-Google-Smtp-Source: ABdhPJzPYtQSjM7E1Am//z+Jg/d3uZz0tHdEud143+XMuYtndFhkpEEIGLw7NRvrz/p37F+mpFSCRw==
X-Received: by 2002:ad4:5bee:0:b0:432:f52d:28b6 with SMTP id k14-20020ad45bee000000b00432f52d28b6mr2840554qvc.44.1645960584406;
        Sun, 27 Feb 2022 03:16:24 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id bs11-20020a05620a470b00b004b2d02f8a92sm3587402qkb.126.2022.02.27.03.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 03:16:23 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     cgel.zte@gmail.com, ebiederm@xmission.com
Cc:     akpm@linux-foundation.org, balbir@linux.vnet.ibm.com,
        bsingharora@gmail.com, containers@lists.linux.dev,
        deng.changcheng@zte.com.cn, linux-kernel@vger.kernel.org,
        xu.xin16@zte.com.cn
Subject: Re:Re: [PATCH resend] kernel: Make taskstats available via genetlink per namespace
Date:   Sun, 27 Feb 2022 11:16:18 +0000
Message-Id: <20220227111618.2043152-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223045639.1932955-1-xu.xin16@zte.com.cn>
References: <20220223045639.1932955-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> -sh-4.4# ./getdelays -d -p 186 -v
>>> print delayacct stats ON
>>> debug on
>>> Error getting family id, errno 0
>>>
>>> As more and more applications are deployed in containers like Docker,
>>> it is necessary to support getdelays to be used in net namespace.
>>> Taskstats is safe for use per namespace as genetlink checks the
>>> capability of namespace message by netlink_ns_capable().
>>>
>>> Make taskstats available via genetlink per namespace.
>>
>> Let me add a polite nack to this patch.
>
>> Taskstats is completely senseless in a network namespace.  There is no
>> translation of identifiers into the context of the receiver of the
>> message.
>
>The interface of taskstats is genetlink that is sensible in net namsespace.
>
>> To make this work requires updating the taskstats code to do something
>> sensible when in a pid namespace, as well as when in a network
>> namespace.
>
> Yes. Taskstats already does convert the input process ID into the task in the
> correspoding pid namsespace. Do you mean to add some check of current user's
> capability like SYS_ADMIN or else?

Actually, here, I think it's meaningful to set the genl_family's netnsok of Taskstat
as true. As you said, Taskstats itself is senseless in a network namespace. So, we
don't have to limit it to the only init_net_ns, it is basically okay to make it
available in all network namespace. Certainly, maybe taskstats itself also needs to
updated, because it does seem to be missing something to just use CAP_NET_ADMIN as the
acquisition restriction of taskstat.

Thanks,
xu xin 
