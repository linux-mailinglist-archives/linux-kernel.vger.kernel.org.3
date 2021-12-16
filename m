Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CACC477809
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbhLPQRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239400AbhLPQR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:17:26 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688E6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 08:17:25 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t26so8808701wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 08:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sheffield.ac.uk; s=170424.google;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=sGzsk9cQFFTx9AQpWtm+YKzXZQilCsEWk95xq52AJ/s=;
        b=egITjsAn64HnojR+qUVINlWpDz3mSwXg0/hEV2rNy/SndP4LMuG8UMQedUg31I6mra
         VP5haIjHqf9SQe4JDxx8UozPdGN90EMHR54mxw/SwUZoPrfg/vxdj0cz4CrgBy8/g/up
         SVL12kExYnHD2lnGHZ6f8SJ8nA89qP+hQbA5WFdXJbAE0yxFsaiclAdMq6Yyf0iJ9uEP
         +Y1baA5d+y8KtTmGqoxGC8CRpgli1Nq2TMvgfNRq81DpxSwO2z8mNSA93lyAQwplzmXQ
         29VmqpS6TzTpndoevCVqpFN/qrETFx/Q/B53Ogw28oL9cQWW8CcBsc6I+pSAy6wdepdI
         wiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=sGzsk9cQFFTx9AQpWtm+YKzXZQilCsEWk95xq52AJ/s=;
        b=3R2CiPE+SpCmBGK5JKjK7/TfWnAuuVnUsCp74RoHOxth82UukkYen1reSKNsmc+eKS
         bCvB1ZgndcAmqHSIrv1Dp+OeU5tg1HQ+XpYBkH6TtoiV5VqNyCPR/6HYbiqDl/jvr9aN
         cxEHJvxx5eZHTb6OrsRUks9YjfxwCwPw4URYneH7i4JecDbBHRNoW3ItBMylRjT+giP+
         DFhLMmSWNONVAYppB7jgmXKUPacH6plarmSpp3F9HWJhjRDTIT7oF0eIBUOLOYeVIQBy
         AoI5HGQfx4NLwX4zWkQTtdk0NXCibgbEVJBzVl8N7SbrZbuvJ7QfSQAiBwLCJ628Tpxw
         VUfQ==
X-Gm-Message-State: AOAM531Fi6n9PmFH74gBLrLsg/BotPqRmCNUgzgxcf4Tq/bdxcwp0eyL
        mkRfL8mzQR957IttFA0LDen8BDwbL7PiVGvM82EG/bDdFKEfbG6PV4pz4NfWPjHFXtQEIQiZi8d
        Gny/q0pQ7ZJO0Yx1XdkXzN5ngj0JhYJXfS0iwmC5SCp+2TE6aCw0URXG63FWdCUehMbuiIv7Z9L
        Y7oll5bevWgI4hqzJ93tUP9AAswSvufXybEQ==
X-Google-Smtp-Source: ABdhPJzBReiwuqeWCZVNygHw1pN0vQ4Pz9W1xBUGb7tYBioAtJBW3Ws+cC6vnXlhEFkBzX9SIRAeMw==
X-Received: by 2002:adf:c146:: with SMTP id w6mr9846291wre.541.1639671443579;
        Thu, 16 Dec 2021 08:17:23 -0800 (PST)
Received: from ?IPV6:2a00:23c5:5988:1d01:1d50:744c:24f9:bd98? ([2a00:23c5:5988:1d01:1d50:744c:24f9:bd98])
        by smtp.gmail.com with ESMTPSA id l6sm5442254wmg.3.2021.12.16.08.17.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 08:17:23 -0800 (PST)
Message-ID: <0f2393f9-7f1f-1e83-faee-f9b5e376892a@sheffield.ac.uk>
Date:   Thu, 16 Dec 2021 16:17:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-GB
To:     linux-kernel@vger.kernel.org
From:   Dave Allerton <d.j.allerton@sheffield.ac.uk>
Subject: ThrustMaster USB interface question
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I have interfaced ThrustMaster controls via 3 USP ports on a Raspberry Pi.

Everything works fine, except that initially, the digital inputs are all 
zero (OFF), even though a switch may be set in the non-zero position 
(ON). If a switch starts in a non-zero position (ON), to read the 
correct value I have to flick the switch off and then on. Is there any 
way to read the positions of all the digital inputs initially?

Many thanks

-- Dave

=====================================================
David Allerton BSc,PhD,PGCE,CEng,FIEE
Emeritus Professor of Computer Systems Engineering
Department of Automatic Control & Systems Engineering
University of Sheffield
Mappin St
Sheffield S1 3JD

Visiting Professor Cranfield University
Honorary Consultant CnTech Co. Ltd
Managing Director Aerosoft Ltd

phone +44 (0) 7754-486866
email d.j.allerton@sheffield.ac.uk
book  http://www.wiley.com/legacy/wileychi/allerton
=====================================================

