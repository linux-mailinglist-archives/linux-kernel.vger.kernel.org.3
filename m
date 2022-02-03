Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DCF4A7D38
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 02:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239827AbiBCBGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 20:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiBCBGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 20:06:36 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC2FC061714;
        Wed,  2 Feb 2022 17:06:36 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id q186so1640068oih.8;
        Wed, 02 Feb 2022 17:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XRZmM+yaTnrVXpm5gsPPe5Kc/OSxRoCOhAGPC+u+DTs=;
        b=Ek7bPRQrd0HW3noavBdgbZo2tj2V4Pyo1Msu4prfYQ+zOxE1PPHLUoKAywMSAwP+1f
         83EdRigiIJCiwxcTJcr6dYTaXN216dgrGX7p22dKU7uv/LLQ7o7MnOP3WvxDzOpgBshV
         vCyGyNLc0tTYN3PvPfnwq4PuAzBh9VWl6H8BKH9Ug3kkwkJIwD6xd+W9c2oj29s/wyXY
         tcJxZwVjsWoC8LpeYItd60/N+vjXXRSPUZMbeY+Ale1ZmMlK0eaP9tpgeF2TBWsjZmYu
         /spSxhZS9MTZnUFrenvRObWQP/K6fQoLclV3cPxaYfVCHF9QerDRERsi1Uov1/2ni+b8
         +HFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XRZmM+yaTnrVXpm5gsPPe5Kc/OSxRoCOhAGPC+u+DTs=;
        b=I7iyztx0bpyd/L0e7sDvMN+ENWX7AdI1H1Jf1Hct6jNy3V7Zmh+bj2z6LUio/jO3mK
         BkYRKQ1TkeBAdKCLiXhbqZ30Um7Ec9qM7i+BoFLmX0WSmdKdh+UYZgxSq9QBw35mBigY
         VCCUeBrWMlDXcnPrNB2Is9SKvjFVazIuE9TuVeM/C90kBolkxYp8XZAW4NwDhHqNktYX
         PUEluMUZWqj+SuT6oB40okeIsYcK/FpIjfxDUqhKLEjdA5BPXDm3GpIW57bDQW3cTOVn
         UfFfOaGMfF1XQa5T80H8VpLs7x0bRcpo1V0FDddQ9aY3lMtawaXCpZJwf5xUdRmJxeRM
         lAvQ==
X-Gm-Message-State: AOAM5326XwiqW/LdAhbOL6XXPsrzwh0xq/b8DDaUvQ6lQP9ldKuyHmHT
        +Dk0FoQEwuItdyJCB6aGHKg=
X-Google-Smtp-Source: ABdhPJwSh5vIjruqCfqk69xhz9sxRAo88Qskj8Gn+aZPY77LL7QnhQT0OYPxGsN+CFPC16BYXeT/dw==
X-Received: by 2002:a05:6808:23c9:: with SMTP id bq9mr6280196oib.138.1643850395728;
        Wed, 02 Feb 2022 17:06:35 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j6sm7040088otq.76.2022.02.02.17.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 17:06:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Feb 2022 17:06:33 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Armin Wolf <W_Armin@gmx.de>, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] hwmon: (sch56xx) Automatically load on supported
 hardware
Message-ID: <20220203010633.GA2544812@roeck-us.net>
References: <20220131211935.3656-1-W_Armin@gmx.de>
 <01e51bfa-5107-fbd0-6a0b-82bca6c78e8e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01e51bfa-5107-fbd0-6a0b-82bca6c78e8e@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 01:57:02PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 1/31/22 22:19, Armin Wolf wrote:
> > The hardware monitoring solutions supported by the sch5627 and
> > sch5636 drivers are Fujitsu-specific.
> > After some online searching, i found out that the solution used
> > with the SCH5627 is called "Antiope" by Fujitsu, just like the
> > "Theseus" solution inside the SCH5636.
> > I also found out that "Antiope" and "Theseus" are listed as
> > DMI onboard devices on supported Fujitsu devices, so the
> > sch56xx_common module can be loaded automatically an check
> > for the DMI devices. However some devices like the Esprimo C700
> > have both devices, so after verifying that at least one onboard
> > device is present, sch56xx_common still has to detect which chip
> > is present.
> > This is safe however if at least one device is present.
> > 
> > Tested on a Fujitsu Esprimo P720.
> 
> Thanks, the new version of the entire series looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 

Series applied.

Thanks,
Guenter
