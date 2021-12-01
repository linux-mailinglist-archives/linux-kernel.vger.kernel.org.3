Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567D146574F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353226AbhLAUqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352981AbhLAUny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:43:54 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C18C06175D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 12:40:26 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id u80so25781513pfc.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 12:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=To3FfSqv1AaOm/uB/4nrwNgoQmkVXqiEENRWHfT1TrU=;
        b=fw0slW8dxNEvZ8cQ9TEh/wUcudS59bTNWJwJtht97u6Z2LixWo6/Sod+mXrsV2t4BF
         02xtcyTnpPvKN/qqTF4guGgSrpfTQnn41lD2M6OToIXNkEDVrz+sJXIJ/ImHNs4gkwCh
         +eKONBXGKdy2AYm1GL+5YLm6MX7aP2afjLgRJ9ybphn61TfRczxkCnJm/QY3m6wdXtro
         clZIck2wiRUHc5gS/n2XkLlCELc6X0ObjZ7oTdKBArWWiA/NCkWPOceVg/ItR/aQ4EjN
         cugOL477pJM/d07acVVYhrGjS7hZTbIVJD3xrytprbfDjugOgQN+lv2Cj7cldR0Iak4d
         dCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=To3FfSqv1AaOm/uB/4nrwNgoQmkVXqiEENRWHfT1TrU=;
        b=drWra5s1GeBxWYO+kJPK6r3WjrnPiw+41WrJWGM0QPWkaaGbc/c9P+kDdO4SVSNa3j
         Gh/lyySLBVbbai7VXLWtWQxGaOXhSpdcq5owqZaTPV0+uYEYCx6p/t2DbWwZd+GHswj+
         FeMPwwtExLRIjpbU3U9xjChA2GvCyGbKcZ3WetXDUXqPbCAhPq93KCSqPAicm2Prw6oG
         Gp0vQ90qKBZAfZMhBfWBse1iGFSCEkUDOLnXteLqe+kB1hZ2SeHvIjGoCkAZoxen7E0N
         rjbvtqx4b8P2TvEM43Z8wsMdWI5hfp6JxD57icRqAYsz+FBdd+HCndFMt09yNuAR9xTc
         ogiw==
X-Gm-Message-State: AOAM530Y0BQx6ZuI4znDF6cxbjWlJV7CdYZFVjt1+t8+6k/6B1T3rAi1
        1jC3o/IJ0IHzfxlffBDeVNn/dlSuAZU=
X-Google-Smtp-Source: ABdhPJxj1CheAHOoobSKBt9vUG3Ms0Dbm85RDDdMI78v9oDK8UzUuRGBTkSM42AxYNpTvAlK6vKYSQ==
X-Received: by 2002:a63:6b49:: with SMTP id g70mr6394210pgc.418.1638391226288;
        Wed, 01 Dec 2021 12:40:26 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id r8sm479323pgp.30.2021.12.01.12.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 12:40:25 -0800 (PST)
Subject: Re: [PATCH 2/3] usb: Add "wake on" functionality for newer Synopsis
 XHCI controllers
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Vinod Koul <vkoul@kernel.org>
References: <20211201180653.35097-1-alcooperx@gmail.com>
 <20211201180653.35097-3-alcooperx@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <38275ba2-a750-9d34-1f2a-e9eccbd2145f@gmail.com>
Date:   Wed, 1 Dec 2021 12:40:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201180653.35097-3-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 10:06 AM, Al Cooper wrote:
> Add "wake on" support for the newer Synopsis based XHCI only controller.
> This works on the 72165 and 72164 and newer chips and does not work
> on 7216 based systems. Also switch the USB sysclk to a slower clock
> on suspend to save additional power in S2. The clock switch will only
> save power on the 72165b0 and newer chips and is a nop on older chips.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
