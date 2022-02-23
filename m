Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684684C0C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 06:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237146AbiBWFo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 00:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbiBWFo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 00:44:26 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549143EABC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:43:59 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2d6d0cb5da4so143674157b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eodUpTPWhYKf4AxltKUgxmHbO5CaYYvg7LhtDPIsTcM=;
        b=cAX+Ddp7L2gX4YZhVvsBdwNsjk4mRAEW+Ul3CnDPoWjqFYDSD0jpmzh/BfNxLg1nsQ
         3CSJQucaZiq63aNGjh2MQRKIFe31NNIdOehrK67t+suwDsL1gh+zwIkXl+87vRM3f9ou
         jVUHjXZZjmOwuGbAvagKZqt1ghx2+y3dR9WtIQSxKVOmFsgzpWryzQQc3vbk8XIYoCuV
         LQ1VTWrV8Wb+q/ou5zKqm/UoEMlDyLbzEjOq/xQjYu8x3rrTdzDcuUBa0I6h9+O1Ulj2
         cAHMcYua7+LUVIsUPUX4XIWAwqm29Kah5DEQC+BJ+Hmb0dVi0IBzZEfW8aHux+f9kw6N
         UOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eodUpTPWhYKf4AxltKUgxmHbO5CaYYvg7LhtDPIsTcM=;
        b=p3j4aVrIL0HKUOVDouDuUe2rq9aV7Hw9Zy5EKwiaQRIBqzRkL79YXj8MoTfmKzV26I
         dlnmnukBPkuW864M3Am6S+VwOZ0Pq4D/Pd9LamZUVgm1vS343MaldbcI5s9nrVhXS1ok
         79o87fXY+6yuXAy7GrCKydu4FKCLxu15D0tR++/jUZ+Ur05+pIVVWNophb5DsVfhER/f
         9FqBjXokaTi7niVq0GJRULEgn6OdAxr9QyZHrk57R4gFOJAm0KsxGjg3gsL0RnIfRV3D
         J6ipAzAOAO2ESsNdF6S50X8tcNVgGdIAnQZAnGYqbNUvBgP5/0dQkUk4TffUyA5Q4Ztl
         NIWg==
X-Gm-Message-State: AOAM530cWl6rU9WFKA4du8LE44EHpFOrIHfKwFL06K29Y+0pEL9C17CH
        9G4kmuIoLBkPmd46A5skF7k/FQYFUP4nVcedIIo=
X-Google-Smtp-Source: ABdhPJxxOtgK+SZTJRU6dGf+rHY9WUQ3DO3u300cyAZRwwurIdJg6iBLfNhGBEVYEEtiqtZhaAqOpDgdAxzV2JBbK6w=
X-Received: by 2002:a0d:fcc5:0:b0:2d6:8eec:b2f7 with SMTP id
 m188-20020a0dfcc5000000b002d68eecb2f7mr27223356ywf.439.1645595038400; Tue, 22
 Feb 2022 21:43:58 -0800 (PST)
MIME-Version: 1.0
References: <20220220231554.2510567-1-ztong0001@gmail.com> <YhPI5iDRUpzYWDyY@kroah.com>
In-Reply-To: <YhPI5iDRUpzYWDyY@kroah.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Tue, 22 Feb 2022 21:43:47 -0800
Message-ID: <CAA5qM4B40s7qPY2kipffK+zCZrovA9Z3k0Cvq6EUYGABcdq91Q@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8192u: cleanup proc fs entries upon exit
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Colin Ian King <colin.i.king@googlemail.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?Q?Cl=C3=A1udio_Maia?= <clrrm@isep.ipp.pt>,
        linux-staging@lists.linux.dev,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, Dan and Greg!
I will revise as suggested and send v2.
- Tong
