Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A384DE4D9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 01:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241654AbiCSAaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 20:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiCSAax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 20:30:53 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCA31C1EDE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 17:29:34 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id x4so11085869iop.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 17:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+RZwrR6jIx0T4lWYA/TV52jgdAigjInQkREvX8FafCg=;
        b=XMnbvCZBwdmj9tiI6hn+oGcWQ7U13yopenWSJ0tfhytZBMb1lSQ9UeQG7NvNhuOVkQ
         Db3O/4l3kR1X3yiI2jx8kKOzMsNutB70NedfSq4L/jIxQBIdadmWCE7qB2geEx+lxEaN
         6t9GIw9/OgpeibYkfiDMQPIFlOvBLprPajgIuKbWzAc82ADxrEnGDS5ptfz9GYi/WNgM
         bQPp4zQfC3JW+AtoxlK3xXai4kEaY+9c6l048dM9uOAbjHq0TKrp4SWaawlq2rFEXbm9
         bXnMcefkfVRyrQ/ik1E4HMyu8AzaPr2GzcGiShExFfKEA59bedLFYMM85EpkQDgufvcS
         kjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+RZwrR6jIx0T4lWYA/TV52jgdAigjInQkREvX8FafCg=;
        b=UfTYqi+LIgsL0gv6pW0lTdtlwdC4RImpv8PNmRfAexe6CqUPaiNWLCs3OsJYLgrK/4
         yNLnzz9a0ni+YN1o06q0lMmDefH8Kn4empthqZTfT0csA/ttwQquIg+tGPwtVkJAXQwZ
         0j/50i1O2sE449B2/+Y1pwDkqtpCDdM6/+uBBr9brX6PtvWH8iv3SwnQ5f3h5IYLsHl7
         8YSQh8cMPi/JCDp4Y2hqWqrGodUnsVmByCBAN6+TUqiwXDQtagHZPRW/4FJBfUoBqBHV
         u1Y3NOW9WeUB1DcnOYu3wcgYCWCrKFv4GSnty9FKRub93n1FG+5XXOdV5I3YINWv2Dap
         FIQw==
X-Gm-Message-State: AOAM530Smid1nxA5CkKW+BQuZ9xgiLhNVRmHPX5NoHWI8KmwNoUKPYLM
        /zIHrP3BsWfDDWIo2SjipDAQl40Dxw5N1HzVY4JIKDk1hsA=
X-Google-Smtp-Source: ABdhPJwrCWMHPIPFSz6GEOZnDmrazHI7ghETr9Mds+Gs9ndwMm7HrbH2rK97cIPOjwNKyJ5X1WOFJo+IOB48b0DmNaQ=
X-Received: by 2002:a05:6638:259:b0:319:e237:b6f9 with SMTP id
 w25-20020a056638025900b00319e237b6f9mr6080758jaq.186.1647649773944; Fri, 18
 Mar 2022 17:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220308151119.48412-1-andriy.shevchenko@linux.intel.com> <20220308151119.48412-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220308151119.48412-4-andriy.shevchenko@linux.intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 19 Mar 2022 01:29:23 +0100
Message-ID: <CANiq72mVnHWi-tZmT4g+2Y96eYu=Hm=oMKn6RkwpXWh7ARATAA@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] auxdisplay: lcd2s: Use array size explicitly in lcd2s_gotoxy()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Mar 8, 2022 at 4:11 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Currently the reading of the onstack array is confusing since two
> out of three members are of different types. Let it be more clear
> by explicitly set the array size, so everybody will understand that
> parameters are cast to the type of the array.

I am not sure what you mean by this, could you please elaborate why is
it more clear if the size is given?

Cheers,
Miguel
