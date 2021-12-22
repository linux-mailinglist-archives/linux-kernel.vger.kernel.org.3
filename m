Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A4A47CB6A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 03:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241857AbhLVCs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 21:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238762AbhLVCs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 21:48:28 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D004C061746
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 18:48:28 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id j124so1725644oih.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 18:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/FZUFL2wLkEGZGFTbPONkk6mLWd8J6cDzMFXomn323A=;
        b=Niimf1jllbIyv3wnG8/DrqRRpShYICD8EWAfwYqJY8qcVGHPp/f2EqajPpp/OQ55iX
         7avYtd0TmboDXiqV4tshfdp7cv/Y4/zbfmr6GhPhXYMEd3RJyNmCADsOeW/Vpwl+ZvIT
         LCNinerXlMPpFLuJvTQh3YrZ3jK8M543vM7IfidOglerQpDjrYzdYHBP6gSN8eYW9nG8
         ezvZHL4Eh4mkMiiOTgSwT3gL+IUApU4GILXtkZatXC0KV1jRk+jCLVJ86BMVK9p+m7zu
         F5KqUESKLmMKEKql51KlJO9x+//yei5FefBnN6rCNbYCyK6dNQmRq+6xk8cp/8TH+Z84
         sG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/FZUFL2wLkEGZGFTbPONkk6mLWd8J6cDzMFXomn323A=;
        b=RwpbPJnfaVRTfVxYtfoVVBOebEgxmcD04JgauF4QGOGvfoh8NRAxnibqfbB647xiHR
         ux58oPkZuUvStYo/zd43AekEYy0kqzFrwCTGYl1QUlcnZ3BZSPZRAZvMRYiNhpdESEPt
         E/da9hLkeXE7aJTNBY4JJ6ZEt0y3Ot3G3IwLLf1JExDxtvs8XYMye2zqiVM+Me4HLGkl
         snu15/qrIEZu9UJZ+ChQQGjCBEH1juE8zFt4vatjo8GnYXcCzgARhOL9ptUueLCp8Ll4
         TGLOHCTaD1Lc2YHkSdTf8KXM+tXHuIQTjnmgm+yBMUEGHrFVw1p8hu65reEVuqpi1nVu
         7HtQ==
X-Gm-Message-State: AOAM5308KopMq6kw8p2q+z0wvOxCr6nDretHpySA45rl7wIT8zI0Kmxy
        hIM6djY1uum2sE4xbbln1iaNuvhdSDCe/JekSFOPig==
X-Google-Smtp-Source: ABdhPJzgjgZvCZer+0qK1pclgej1TT1RDlfQKfCQvqjVS3qOHMzJGGAXe5nK0e/t6ph4iTgc1ECudtqKVJBwg9u1Q/o=
X-Received: by 2002:aca:120f:: with SMTP id 15mr742282ois.132.1640141307641;
 Tue, 21 Dec 2021 18:48:27 -0800 (PST)
MIME-Version: 1.0
References: <20211221181526.53798-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211221181526.53798-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 22 Dec 2021 03:48:15 +0100
Message-ID: <CACRpkdbLk1aHEaiumq3d4qmg007QtZcitmCwdyFyLxyY=H7MXQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] platform/x86: introduce p2sb_bar() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wolfram Sang <wsa@kernel.org>, Jean Delvare <jdelvare@suse.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Tan Jui Nee <jui.nee.tan@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Kate Hsuan <hpa@redhat.com>,
        Jonathan Yong <jonathan.yong@intel.com>,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Henning Schild <henning.schild@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 7:21 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Please, comment on the approach and individual patches.

This approach looks reasonable to me so FWIW:
Acked-by: Linus Walleij <linus.walleij@linaro.org>
for the series.

Yours,
Linus Walleij
