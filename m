Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8249D598173
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 12:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244080AbiHRK1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 06:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbiHRK1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 06:27:46 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B1D578B4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 03:27:45 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-333b049f231so29477567b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 03:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9fVsXAu4P1Mgde2oXVo+acOsn6aaMkcFelHwjHZBtQg=;
        b=ssuAI6l4hjntpbmueNgtSHDC29v5f1O+mGRjmyJJv0hT3Uv3KlV9DL3pg/0KKnx+rw
         ezwUvGh/yZaOrsyyLxhBsEuD3MUR2sXNTrlrkCvnLqO4QW6JCtJ1SHlTKS4iVTXNPzT2
         B7FGTaMSiCJAsH6p7nYVp+Yw/dyG3ifNFD3i/kwhUQnD/CARsauUaKmJcB87dQwdqUMQ
         aD25gvAzwML2DSe2P78IqRWIzTL4eFP+noBGmbo+8mcXMCdOnlVTflATol1Msa+onCry
         v4ukhOwx5GZu+o7H7GBCFlO5mjQ2chxL2Cxtr+3OwDiw4U1KvziFaJFCLkO2zKW/sRXT
         oiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9fVsXAu4P1Mgde2oXVo+acOsn6aaMkcFelHwjHZBtQg=;
        b=va5O6FfpXFPcNEOfVduZ+4pDpKvYKqW0SBp/n68IdLj8L9l7DHE+/tEiI3CeCevphB
         fNtC3p0e/sdlLoXmCnPvoveYdC2bHaa+wR/Cxvr0q8zK818dwCjYarpOFJ6NqquBGKsy
         C+pTEB4Xm6smyURwl74bRy7jR/nQ50uTZUTrSj8QI80gSDjCCl90z3FQ7V/aZf249+og
         qLp2eWUn7i1PlBVikEY0afa4rdu979uzpVApceIcdGJgUHrTcq8hY44ZJ0zeDPg9EAiE
         WGnQ7p4faJxrpbkc1d+FWpKunD6d6xVBHEIwWEYKbDizCjOrRdUwC7MQw/Wf3orp9jRy
         uMxA==
X-Gm-Message-State: ACgBeo3YdzJWaOfLYehbfWfsvhxK8sKb+Z3fcwbjKvIdRmMAbAnpqfbh
        OT8zxzA3YE2k2ySaa8ukSw1DHCs/kUkG9k3L29/1BQ==
X-Google-Smtp-Source: AA6agR4m5lJa0HkfYL1ZG0xr9bWmM3g0q53YO0ZnhUFTPsvg8PoJV/BmTB6FTmYvhNSVT2PFs6UEHy20RK5BdrsxLGE=
X-Received: by 2002:a0d:c981:0:b0:330:dc03:7387 with SMTP id
 l123-20020a0dc981000000b00330dc037387mr2149397ywd.380.1660818464648; Thu, 18
 Aug 2022 03:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220726080504.4185715-1-tero.kristo@linux.intel.com>
In-Reply-To: <20220726080504.4185715-1-tero.kristo@linux.intel.com>
From:   Angela Czubak <acz@semihalf.com>
Date:   Thu, 18 Aug 2022 12:27:33 +0200
Message-ID: <CAB4aORWWL7w1rVCrFw-Q2aof6WeQZR5iYRFg2UrvQQwHZzy7hA@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: fix the report-id passed in via set_or_send_report
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        jikos@kernel.org, linux-kernel@vger.kernel.org,
        dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tero,

I believe this is not the right solution. To my mind the spec does not
mention anything that the ID in the payload of SET_REPORT command
should be altered; you have a full byte to us, so why not?
Other than that this will result into problems with sending reports
via output register: for any report with report ID >=0xF we will get
the same report ID in the payload, so how could the device know which
one we have in mind?
Dmitry's rework was intended to actually solve problems with large
report IDs being incorrectly overwritten with 0xF.

Regards,
Angela

On Tue, Jul 26, 2022 at 10:05 AM Tero Kristo
<tero.kristo@linux.intel.com> wrote:
>
> The formatting of the data passed to the i2c HID data register was
> changed with the re-work of the i2c-hid-core. Previously the report ID
> passed in was encoded as 0xF if the report-id was greater than 0xF
> (similar to what is done with the command portion.) Now with the rework,
> a full report-id is passed in always, and this causes the messages to be
> rejected by the i2c controller. Fix this by encoding the report-id
> field in the same manner as previously was done.
>
> Fixes: dbe0dd5fd2e0 ("HID: i2c-hid: explicitly code setting and sending
> reports")
> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid-core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index c078f09a2318..156b12f840c4 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -296,6 +296,9 @@ static size_t i2c_hid_format_report(u8 *buf, int report_id,
>  {
>         size_t length = sizeof(__le16); /* reserve space to store size */
>
> +       if (report_id > 0xF)
> +               report_id = 0xF;
> +
>         if (report_id)
>                 buf[length++] = report_id;
>
> --
> 2.25.1
>
