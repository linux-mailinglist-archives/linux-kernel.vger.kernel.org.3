Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E165515CDC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 14:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239419AbiD3MZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 08:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbiD3MZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 08:25:42 -0400
X-Greylist: delayed 527 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 30 Apr 2022 05:22:20 PDT
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8527B12E;
        Sat, 30 Apr 2022 05:22:20 -0700 (PDT)
Date:   Sat, 30 Apr 2022 14:13:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1651320808; bh=DT5/86canTZHX2ROrTMFnYpWQTQ8t6bIymKCu+253LY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L9Y6GqstX49RWzFh+5HGKKco8NsZfj3SN4p+EcvonpQAphgOVz6FfS8Wt7CuGu/Hw
         ilTs6ccH990Ei+1wC/g9xyowAMV7dRKAtDidxpQY0NnkTm/BMQVP5dLMnyogdx/rlt
         4eCN3Ih0FvKWM7Luybm7G/GUbgFBYos2inKltwM8=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [External] [PATCH 1/2] platform/x86: thinkpad_acpi: Restore X1
 Carbon 9th Gen dual fan quirk
Message-ID: <9270b2da-0cca-422f-8bf8-4b1fb9aa363c@t-8ch.de>
References: <20220429211418.4546-1-lyude@redhat.com>
 <20220429211418.4546-2-lyude@redhat.com>
 <d3461670-a905-4956-4f4d-d847adf4289b@lenovo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d3461670-a905-4956-4f4d-d847adf4289b@lenovo.com>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 2022-04-29 21:25-0400, Mark Pearson wrote:
> Hi Lyude
> 
> On 4/29/22 17:14, Lyude Paul wrote:
> > The new method of probing dual fan support introduced in:
> > 
> > bf779aaf56ea ("platform/x86: thinkpad_acpi: Add dual fan probe")
> > 
> > While this commit says this works on the X1 Carbon 9th Gen, it actually
> > just results in hiding the second fan on my local machine. Additionally,
> > I'm fairly sure this machine powers on quite often without either of the
> > two fans spinning.
> > 
> > So let's fix this by adding back the dual fan quirk for the X1 Carbon 9th
> > Gen.
> > 
> [..]
>
> I just double checked this on my X1C9 - and it's working correctly. 2nd
> fan is detected correctly.
> 
> I'd rather understand why it's not working on your setup then just
> re-introduce the quirk.
> 
> What happens on your system when the
>   res = fan2_get_speed(&speed);
> is called? If that is failing it means your 2nd fan isn't responding and
> that's not supposed to happen. Could you let me know if you get an error
> code, if it happens every boot, etc
> I assume when the function is called later it works successfully?

I have the same issue.

To me it looks like this:

Probing for the second fan calls fan2_get_speed(), this calls
fan_select_fan2() which in turn checks that tp_features.second_fan is set.
But at this point in the tp_features.second_fan can not yet be set because it
is either set from quirks or *after* the probing.

Maybe some of the matches for the quirk TPACPI_FAN_2FAN should also have
matched this device?
It doesn't do so on my device.

> Also please confirm which BIOS and EC version you have.

Linux: 5.17.5
BIOS Revision: 1.51
Firmware Revision: 1.32

Thomas
