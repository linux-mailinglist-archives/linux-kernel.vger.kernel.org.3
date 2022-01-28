Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059184A00EB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344188AbiA1TeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:34:20 -0500
Received: from mail-yb1-f182.google.com ([209.85.219.182]:46063 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiA1TeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:34:18 -0500
Received: by mail-yb1-f182.google.com with SMTP id h14so21431435ybe.12;
        Fri, 28 Jan 2022 11:34:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cRqgU0nu/LB1n9dzYDIOe4yuXdI6Pl7WWyvKr1B8QkM=;
        b=Q4dkg4LI6Mwv+kIdrihxosmCNC9BSWSMCo1Iguag2X/F1bmO39no+JMvfDrhtgInhZ
         1WEz0wjN6meViEWethik/qHSSsaFvt0GjyDaQgxIZ5BXP8b0y7pwE6AzDxKgX+djuxrp
         CoVPGnY88FFJ7Hu2OvMtvyXbU5ZKlLTwIoCHNZG2JE5N2g888agt53z4p15Ms8quwrDX
         XrmZTJc/4gXxVP2ugs3Q9w18I+5ZAjOP6RowF+X1b4L9qotsLcfSAB869j7HMOh7wqMu
         Km/jXrvVqmNp2pIbnUou1XMzxAHcdKqm/CCW5LDUPhHcnBX2xE66Z3Sw41F6E+Z8csAO
         YCmQ==
X-Gm-Message-State: AOAM530LsoieRjZ6kSXcZ4Ru+NhivVDAuxnYJQ6pCWqCIqUSRJoF0cOI
        uyD3uIqC+58m5s1jQyFAFiJUk4QrxVdBe2CVkdg=
X-Google-Smtp-Source: ABdhPJwXW1X+cii4xrgBZvmyNSKPRN4Hscq9N9dcvzONAzS1FVNXOsI35reqlGo/Q33uUZSaPoKLg+rBpdLaJL9OXrY=
X-Received: by 2002:a25:2ac3:: with SMTP id q186mr15078034ybq.272.1643398457787;
 Fri, 28 Jan 2022 11:34:17 -0800 (PST)
MIME-Version: 1.0
References: <20220111103346.2660639-1-abailon@baylibre.com>
 <7hilu9xe7n.fsf@baylibre.com> <CAJZ5v0gZFBEKDt6S0H91F5xCjC3qtT6B+cTnv6u1nijMHkc8jA@mail.gmail.com>
 <7h35lcygin.fsf@baylibre.com>
In-Reply-To: <7h35lcygin.fsf@baylibre.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Jan 2022 20:34:06 +0100
Message-ID: <CAJZ5v0iX=SSaPzZNBX8gNMDPCUewiQA_bHxka2pxvtFHxmPxww@mail.gmail.com>
Subject: Re: [PATCH v4 RESEND 0/2] Add a generic virtual thermal sensor
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ben.tseng@mediatek.com, Matthias Kaehlcke <mka@chromium.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 10:23 PM Kevin Hilman <khilman@baylibre.com> wrote:
>
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>
> > On Mon, Jan 24, 2022 at 5:58 PM Kevin Hilman <khilman@baylibre.com> wrote:
> >>
> >> Daniel, Amit,
> >>
> >> Alexandre Bailon <abailon@baylibre.com> writes:
> >>
> >> > This series add a virtual thermal sensor.
> >> > It could be used to get a temperature using some thermal sensors.
> >> > Currently, the supported operations are max, min and avg.
> >> > The virtual sensor could be easily extended to support others operations.
> >> >
> >> > Changes in v2:
> >> > - Fix some warnings / errors reported by kernel test robot
> >> > - rename some struct and functions with a more accurate name
> >> > - update the dt bindings: rename type attribute to aggregation-function
> >> > - factorize a little bit the aggregation functions
> >> > Changes in v3:
> >> > - Aggregate thermal zone instead of thermal sensors
> >> > - Use try_get_module / put_module to prevent thermal providers to be removed
> >> > - Update the bindings, to be more accurate
> >> > Changes in v4:
> >> > - Fix two warnings reported by kernel test robot
> >>
> >> Any more feedback on this series?
> >
> > Hopefully, I'll get to it this week and I'll let you know.
>
> Thanks Rafael,

Done, please see
https://lore.kernel.org/linux-pm/CAJZ5v0jejFG76OfewYg3kmKv4xwLdRBpC+zRpJ9Jom+tqo7qyg@mail.gmail.com/
