Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4157359ED23
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbiHWUJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbiHWUJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:09:29 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EE571BCE
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:27:46 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id a14-20020a0568300b8e00b0061c4e3eb52aso10454000otv.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=7Ti6tiWs7Ru0M2HldJZkH41xq+DJxuiE5LxFt+W9hlE=;
        b=KF8KyNvqFU5HgDaMV37f3asfjnmZ8xdiuRAiQnBFk/ExqBajD/TwElDGQJOHsJH2cD
         /p85k1YRtfWfhnD81flBr5UqpwuJHv9FeU39umI6XugoHRzf2RUMmI077X0PdVoenesC
         eRCEDXC9GBQSHN9EV6+IFY/NOL6AhoDv5uotDo8ovJAD1vzCn/bFfHDmvc5i2ziaRLob
         2rX6ygzpeLKU0fZVI7F2HxdoFfhniMFagEqOnE6YMSxiedFTJ2eIhcma8AUtD8kTY0is
         4CgE9xKhNADJ0DfPVZCYY0qx6z0zEP8ZClvvWFWLmdBRA0sOVdTdI7LHVxYgYcwyCpT0
         BvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=7Ti6tiWs7Ru0M2HldJZkH41xq+DJxuiE5LxFt+W9hlE=;
        b=gT811a59MQ+xV8LZz5YelDfR+hFTnu+XobwuTJPd/Df1nEagdzq0oeHrhIF+pUb+hK
         7baflVFWskkARw4bqyQefEB50XWLSDmtSS63fERiQQIL1ukmsE7eHqCG5m/1PtVJ9f6N
         yXnlAz+B0dtw+wOwF/opFgsVn8LME0Pp+hBDnS+VBLgx8o2+JVA9L3RwcS4J9EB1O9Ce
         3SdsIktaMSoTvyqV2+z6jLXjns2Q6qEmXLJL6Oa1txpsHQuo11VTKQquI2iy202lvEmf
         QZGK1RV9En2fDlZpmdAOCg5TUMzjN8Wkq+ZHbkOvDMX8e3m+At/wXHL4j2Zdkv8omSwb
         sSHQ==
X-Gm-Message-State: ACgBeo2AwZUfDMdPW5xJzW9t86BtyDSnQQkYhvclImJdIBbiFyuUyeFd
        z3DkkczAMNpq8/rDtDV76JkqoZiR39Mym5wz74Kt
X-Google-Smtp-Source: AA6agR7j8tKkytmY42gICk+7Gcs36Hx1TqXhSPx0VAdGEU6KWy5IkXgbmZZzSyMxFNoMCvNgZNbPne+DpodgmMyGc9s=
X-Received: by 2002:a05:6830:449e:b0:638:c72b:68ff with SMTP id
 r30-20020a056830449e00b00638c72b68ffmr9799416otv.26.1661282865833; Tue, 23
 Aug 2022 12:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <TY0PR03MB627527D223A19E65A5DA14E8A36E9@TY0PR03MB6275.apcprd03.prod.outlook.com>
 <CAHC9VhTHF0vhm=1H6ywiZwW3U-eWQZnK8do5o7yCFQ5ykTrCYA@mail.gmail.com> <TY0PR03MB6275C95F5D4D831FC150FF6CA3709@TY0PR03MB6275.apcprd03.prod.outlook.com>
In-Reply-To: <TY0PR03MB6275C95F5D4D831FC150FF6CA3709@TY0PR03MB6275.apcprd03.prod.outlook.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 Aug 2022 15:27:35 -0400
Message-ID: <CAHC9VhTtCkMRo2ozuZyw_X-eyOQ2fZ89p=f9JwXRSRrHwrNo_Q@mail.gmail.com>
Subject: Re: [PATCH next] audit: printk before dropping logs in audit_log_end
To:     Gaosheng Cui <ecronic@outlook.com>
Cc:     eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 10:33 PM Gaosheng Cui <ecronic@outlook.com> wrote:
>
> Thanks for your reply.
>
> This is a personal idea of mine=EF=BC=8Cin the process of using audit=EF=
=BC=8CI find that if the audit rules are configured too much=EF=BC=8Cor the=
 server hard-disk performance is too poor=EF=BC=8Chitting a rate limit will=
 be easy to occur=EF=BC=8Cthen some logs would be dropped directly.
> I think we should print the record to the console=EF=BC=8Cjust likely the=
 last thing we want to do=EF=BC=8Cbetter play the role of audit=EF=BC=8Cand=
 improve kernel security.
>
> I hope that will be helpful=EF=BC=8Cthanks.

Yes, thank you for the additional information on your environment and
use case.  As I'm sure you already know, the audit rate limit, backlog
queue depth, and other related tunables can all be configured at boot
or runtime to help ensure that the system remains responsive in the
face of higher audit loads.

--=20
paul-moore.com
