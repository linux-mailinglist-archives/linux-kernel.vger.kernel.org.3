Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3224B90D7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237955AbiBPTAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:00:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237940AbiBPTAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:00:36 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2B52B100B;
        Wed, 16 Feb 2022 11:00:24 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id q8so883926iod.2;
        Wed, 16 Feb 2022 11:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XRfU/8ZpzajpOdrIHDPlVGXjOKFOtVhm1MloPuHIYhE=;
        b=poTcBF2RbMylQfU29vedWqgqM3RFbQQ19N9qIT/WoO8Nt6WpxKJYlfsnK4ImJDPmWo
         sHugeYzO7wTebnZ3pJ1X6cZV7cOymQ6SKfm5Gwj+eyWvJBMi8SuirPzTsshvhmfRFQaT
         LU994oMgQoqWm+3d9psg2kTeBsYUA4kPeF8z9b6lgU0K/TeiHqYViAHsPNtltOdSNPyJ
         zsIm+IWxgSscr8gEVsXFmZGRNJHwY82f/t/FbVF88w6BSV237soo1VXZzKhgHvGJcP0o
         ppz3cIZm8LcGTOiyoPmnFmIG6Bi9KYz96dOdQj3ZRXixzv1RNNHjs5HKOXsX7othOEGg
         /ESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XRfU/8ZpzajpOdrIHDPlVGXjOKFOtVhm1MloPuHIYhE=;
        b=7YuOVO15WV+ZxlaR9R07DKgIB8LRHmNcVMqNeeisO2nNvqXoSOlYehwVVGNLnkcJbL
         tN4mlP249V6K8hTiEFDLmshvgEyITpJ3sbipYA9trahTYo8+XoxvNaRGmwXONafd+Ajv
         YXxym6bA1PyFP7KHvVm3xZIbyO6UKl19biswTn9d3vKbBdMoDzq5b4q4tTvvUIaaDFkg
         FjPJlyHjL9qv3pbUqr2cyHN+w2Jpo8cvZKeYNpdK/Agp6qQpjKaeyUSWqcdqlY+kBGwg
         o4C3T1HIj9ty4mobFxn7ri3lq8Dc9EjFaO1eK72vnUc29M5Ok/z3f/CWe7ds4x0GMWJt
         DSVw==
X-Gm-Message-State: AOAM532V6Z72RROPAEhoQzcc8BUXEecfcNMlhmvyDsxvzx9PUWpQG390
        Zp6Ne1DL7vgqnNhSDIdf2EF5j0JE5d3pUkwDlkio1DI4Ess=
X-Google-Smtp-Source: ABdhPJwgrHWX2ov5UFIJ65bqUIOkMLpSE4GM2Tgf2hLPD/WxEll+Muyi9W2xXqzclOszW7naBoCqkzdTgqoC74OB5Tg=
X-Received: by 2002:a05:6602:154c:b0:63d:a762:bd0d with SMTP id
 h12-20020a056602154c00b0063da762bd0dmr2759798iow.192.1645038023539; Wed, 16
 Feb 2022 11:00:23 -0800 (PST)
MIME-Version: 1.0
References: <20220216180822.GA3300192@roeck-us.net> <CAB95QASWWMvSSuuwQU=TwZX-QcU=hRPCJVQ0E6Bh29sc4d66Ug@mail.gmail.com>
 <7f3fc06f-cf4e-2dc6-e68a-917117fe8895@roeck-us.net>
In-Reply-To: <7f3fc06f-cf4e-2dc6-e68a-917117fe8895@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Wed, 16 Feb 2022 20:00:12 +0100
Message-ID: <CAB95QARa=XQ0LEEqM0R6YvBDrK1GRn=R+jszagMuzBKdo3pBZw@mail.gmail.com>
Subject: Re: [PATCH v4] hwmon: (asus-ec-sensors) merge setup functions
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, 16 Feb 2022 at 19:49, Guenter Roeck <linux@roeck-us.net> wrote:

> * If your patch generates checkpatch errors, warnings, or check messages,
>    please refrain from explanations such as "I prefer that coding style".
>    Keep in mind that each unnecessary message helps hiding a real problem,
>    and a consistent coding style makes it easier for others to understand
>    and review the code.

Yes, of course. My question is what do I do with 6 other braces single
statement if's now?

Thanks,
Eugene
