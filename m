Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1456D58488D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 01:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbiG1XIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 19:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiG1XIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 19:08:18 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB7168DD2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 16:08:17 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2ef5380669cso34557617b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 16:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XoO5+n5lAtjmhTQDOVl7dv9SMJLx74LKvYh0rgO002k=;
        b=lf+VaVNgHbKzynF2J+uFL/65qWQblyv/9uz1kSSTpdG+YcE1xSbVSN3ZjSlOkui0LD
         oxqD0UuKiRQ6Wrjxnp/A+jXV/dUGvANr6EOypo48O2JJ77SzZsaR7by4hiY8JFm99JXI
         Fsnz8aeYw6gS4lZqBQ7h1C98wUa1NEGt7LYO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XoO5+n5lAtjmhTQDOVl7dv9SMJLx74LKvYh0rgO002k=;
        b=mt1ncxkJu1+FJXr4EEK5ctJ+8eqK41ifhIQHfasXt2ekAu/8Ngbz7oBt1ev6zZh1f5
         wn3usWjv5zeUpBiyz5dU9JQ5RzeHc8TH3CbKBHRU/Q2OSkbI7p6zAXcUTWhlXQOMwA4i
         S65RI1bXKIv/RPeQTvIAHJoVr++cvBY5/KKNsV5oOe2eT0E5HdVkQqhFwqYOtn2XCONg
         YI8wbj5o+Nv8PHtj9X8aAZPEaOMvAvJ7gIvFhVi+M4g8nQXxPD0Tg+f1z2KnmssQCASC
         2ZNZwjE4lrLAVUEh+JuZEo3zICzE1tzGW6aaTriSSAex9F2xgeA8NN9x4WWrf5sgLGlr
         5Kxw==
X-Gm-Message-State: ACgBeo2zfb1wD9vtnTnKNXRQp9jWESMtmosTXO247AHikHeUSQCVasNm
        xYzOMS2vTsB1TI+1GiaokhkN7rG8VuwU/yYwehjvgA==
X-Google-Smtp-Source: AA6agR5oRXRMaifdJbmmaXl+CGlcWTtqcKz1yXvC0+ms6Icr72IEbWbAZYkNL79SKIo5v7cCLBJh1TyvepcI/Wm0FFo=
X-Received: by 2002:a81:81c1:0:b0:31e:7378:960c with SMTP id
 r184-20020a8181c1000000b0031e7378960cmr947411ywf.266.1659049696719; Thu, 28
 Jul 2022 16:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220728144710.1.Id612b86fd30936dfd4c456b3341547c15cecf321@changeid>
 <28005e66-ba90-8986-1b8f-b76bba46064c@acm.org>
In-Reply-To: <28005e66-ba90-8986-1b8f-b76bba46064c@acm.org>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Fri, 29 Jul 2022 09:08:05 +1000
Message-ID: <CAONX=-d-_2bXqf0TCjdJ1u+B3cU3ZkP9WCu3QxqSZT-v3E_4BQ@mail.gmail.com>
Subject: Re: [PATCH] ufs: core: print capabilities in controller's sysfs node
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 11:37 PM Bart Van Assche <bvanassche@acm.org> wrote:
> This code change includes all of the UFSHCD_CAP_* constants in the
> kernel ABI. Is that really what we want? I'm wondering whether it
> perhaps would be better only to export those capabilities to user space
> that user space needs to know about.
Adding the filtering would introduce an extra maintenance burden and
will likely go out
of sync. I don't see harm in exposing all capabilities, both intrinsic
to the controller and
negotiated with the device. Do you see any scenario where that would be harmful?
--Daniil
