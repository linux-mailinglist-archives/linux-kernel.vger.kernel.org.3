Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEC84E88D0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 18:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbiC0QXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 12:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbiC0QXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 12:23:40 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C88549F17;
        Sun, 27 Mar 2022 09:22:01 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id h18so3836642ila.12;
        Sun, 27 Mar 2022 09:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SYh+PkIs8JchTuwkw2+G0wVLXgGV4Hhjl5dldnzihdg=;
        b=OSHwkTIY1Oygy9pl7PymuNKc+1YH8XVzg8uVbcZddmAKBRq2PTrweOcbI9hFZp0NfD
         RN66QcgIkO644vVNyNzMI0gi5radgQvfdaL24TOSvHVeKiw66Z+/BA9ULyYCkuRYEFYI
         rBzxiqD67Ikcjsuf9guIeCx2JKH870WLk6+XN4tWAZ/UQY2QLv9i54+DM3KGVXMgn80n
         SCaZZrIGDcB7Nq+tiMuWli4WfGZ75hipsuaXpGfH6cuAJheUPSdm01kpSzWkYkx61YFw
         hzkKk6pilK2tQmeCnYtSeFwkaLFuPrbktFl+33DvrgbWRAerh2jDFkt7jQDO0m0bg7Ak
         QGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SYh+PkIs8JchTuwkw2+G0wVLXgGV4Hhjl5dldnzihdg=;
        b=R8vlra0OVHcrpriOlDdCipGkC5T1gmj65FNf5ns39ZMIQZ34jgYfaeZjHXKnXTVzmL
         T7Jq8sIGYRmgdKw3v/ulivekAIO7TAd7aEkh6hpKDd1pxrfbhvI/3Rf8sgJYXtLgc/kg
         gRUqvmxte6WpY/RfL3lLhFkwBJmHUvQwnN5+6CQ8OPnuJogYEwDHVYG+WU/p5Xf822r2
         dKlHQux01AbWdgksEkJK03bAI/fa46K6sU8wtJQZgiz6vK163XkTyC/4zb+YZk4ftAHY
         khrttCYs66YHbcGpyaLae/56UpXMdyNdiOb72SHNLZ0XR5lUxUwPJ7Awy06/k8lfP1OE
         obRw==
X-Gm-Message-State: AOAM533NikT8rD8DgGLruchsAtQEejayrQ/aU2XBOk31+7CvX2jfoqVm
        upwyLXiyCiubvk1eZxaJvLm1iO2dvfHwJN9YzcI=
X-Google-Smtp-Source: ABdhPJzguMKSlsQyq0L1yhg/+aFFywIs1BPCQlRtAFvd2zpGCkfyuLNQFihgi6G06vrTYWDMRzm3kXM0H6TJm0RJcNw=
X-Received: by 2002:a05:6e02:1c2f:b0:2c9:ac72:b4b3 with SMTP id
 m15-20020a056e021c2f00b002c9ac72b4b3mr1789485ilh.246.1648398120737; Sun, 27
 Mar 2022 09:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220327121404.1702631-1-eugene.shalygin@gmail.com> <20220327121404.1702631-3-eugene.shalygin@gmail.com>
In-Reply-To: <20220327121404.1702631-3-eugene.shalygin@gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Sun, 27 Mar 2022 18:21:49 +0200
Message-ID: <CAB95QASpZTz4eMger46WEa9xWJNmARShBUNb7edJA1eij3KBwA@mail.gmail.com>
Subject: Re: [PATCH 2/4] hwmon: (asus-ec-sensors) implement locking via the
 ACPI global lock
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     darcagn@protonmail.com, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Mar 2022 at 14:15, Eugene Shalygin <eugene.shalygin@gmail.com> w=
rote:
> +       /* number of board EC sensors */
> +       u8 nr_sensors;

Re-added by mistake, will be fixed in the next patch version.

> +               if (ACPI_FAILURE(status)) {
> +                       dev_err(dev,
> +                               "Failed to get hardware access guard AML =
mutex"
> +                               "'%s': error %d",
> +                               mutex_path, status);

Can't choose between various options to fix this broken string
literal. Would be thankful, G=C3=BCnter, for a suggestion.

Best regards,
Eugene
