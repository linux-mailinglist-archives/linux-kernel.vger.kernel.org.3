Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30464D90D7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 01:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241598AbiCOAIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 20:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbiCOAIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 20:08:07 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCA61D332
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:06:56 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id e186so34102332ybc.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JBuIzHr/hNW9HnE6Wb7cA2vFROsqgqu51wMCBe03Gu4=;
        b=BwQUfr1TiWA50lgUJa4/5OtO3NncrQ7jwFSZ+fYmqj1CdMRsgw64FndNFGz6Ji/Gj1
         8zBXbVA+NHEnX2L6z4ln7DYOKnvpMvhqJUtmFB3wBEpnIgrc5jOEH2LSdO6lm/0ZSoH5
         OlDGNRfArFvUqWXe6WbmtMwTQdkM08jlRokFaZvKLi0fe4d22WPpVMUqRWC1QQnjxEBl
         aVlIVEHnWC0kq82yXUto2rGB0aBxgUZ1G192vNpx3lBshVdKDEl/w0LgPb+iAdQgGPRw
         FC1sZJXyuU/13HgJPM4uYVbaOtzA3Lv+9fpHTCBQJDKExOJNg2IB38MQv44YJ/MtXKCa
         ogVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JBuIzHr/hNW9HnE6Wb7cA2vFROsqgqu51wMCBe03Gu4=;
        b=BzQXyhUOa2iVvHT3Gn5Mq6a9eKkW5UZm5SmGuYd/KItJ8vYi2/qGSukHcDOTmLBmv9
         kdzoIhyubjIEv4C+QeJT0pXG4BBdqid2ejECUPKUzLjO370jDl72nH/yoYcY7jovuXJm
         YoPjlBws4DBeJLJUotNnd7pGL6ywI839zZatQp1+aQLwN2hLYI/QCsr3YfiCaM0IxvUp
         dCed4dBl4Gy7vCxKS/c27zVyzfrTn7OjGm9voFCRxr25NC1t7qjlF8tX6tzyaueB5Evo
         y1qDBZUzlN8af8qoNzch4HBSw5MZ6oQxtU6LJ6neJvySl7Mpmd4zHw912aFo+vskb+eV
         FjzA==
X-Gm-Message-State: AOAM532GoOG3FgBeZcDupKSn5APqVst5dEMYaOEvYpES5tqorg8yPwWh
        pXSl6eipDvt4mZSdgOuSz1ha7q4uCuDeeaR+rJVyfA==
X-Google-Smtp-Source: ABdhPJzmknoXTod2xBAeQXjdNuh4jQWme0RxTMFeHvO2t4kLLwhqTyhxNa0I//BO7FuSoFfI05lv0gg6cO9YHANAhUU=
X-Received: by 2002:a05:6902:203:b0:628:7b6f:2845 with SMTP id
 j3-20020a056902020300b006287b6f2845mr21062560ybs.533.1647302816147; Mon, 14
 Mar 2022 17:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220216122727.1005041-1-michael@walle.cc>
In-Reply-To: <20220216122727.1005041-1-michael@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Mar 2022 01:06:45 +0100
Message-ID: <CACRpkdbYNRrSsQqtfBb4rGjxrEWcw8gQSQZsbYGd2pTQKeJ0MQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ocelot: fix duplicate debugfs entry
To:     Michael Walle <michael@walle.cc>
Cc:     Colin Foster <colin.foster@in-advantage.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 1:27 PM Michael Walle <michael@walle.cc> wrote:

> This driver can have up to two regmaps. If the second one is registered
> its debugfs entry will have the same name as the first one and the
> following error will be printed:
>
> [    2.242568] debugfs: Directory 'e2004064.pinctrl' with parent 'regmap' already present!
>
> Give the second regmap a name to avoid this.
>
> Fixes: 076d9e71bcf8 ("pinctrl: ocelot: convert pinctrl to regmap")
> Signed-off-by: Michael Walle <michael@walle.cc>

Patch applied!

Yours,
Linus Walleij
