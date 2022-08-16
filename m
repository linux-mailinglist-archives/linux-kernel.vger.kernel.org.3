Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17FE596328
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 21:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236044AbiHPTaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 15:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHPTaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:30:52 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E01086C06
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 12:30:51 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-333a4a5d495so67854877b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 12:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Kl58oIVw+b/FQzIKoDxlVtYHvxPN7SoeBGR5DHsWFi8=;
        b=ccA1aqFa/Slrf+EHGuY4jRJf1eDbmsl6+BowsTbKHZ9JwnvfDH9nMdBdtaxJoN6rD7
         8LGhcTb4aFMVtvcuO9LhXudkyQOQCGiGSNMH9j4/v5oP/XdyUvuD8RnqQakRvFqFA7is
         gpwS7f3RHIke69w39Eqa5lyhyWZeuvZrtk4WQ0pFUMMmYyeAZbIvAC1ZoNoiNAeGU61I
         1C1sPfKhdLplcoAueLcGDuY7IMG7ukAtJ1uA/RaZsCjbMBeF/2dY+o2DiAVMET+YiYVE
         rrvfRBxStOypa6jbCQx7nfPrnDpSCbyV1IFKeC9UHO80BcTyNV3tecWavKCb+PrtY/Sq
         78Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Kl58oIVw+b/FQzIKoDxlVtYHvxPN7SoeBGR5DHsWFi8=;
        b=yF8JA3jaC8U/tLoKH8N4+K3mmAtmfIY+z/67ipYdLj8X9zZaxf7LtPbvGwvQiMJ6VJ
         zF88LRWTovLNxMNut4KOQfTXEOpBjqVxOTk0+ul3nhYQJ5svx0l2uuRX4wv/89uefm5x
         3BFU3NLr0jQR4qOsfY9NiBTHz24d7uBXmrdDXx/mQj7+Firbmncy8Xc5kA97zXx5hId7
         58XBDBl1MdWnqPYfRUq2HkrB0bXSkjhRdF6tyvKVk6MNeAdaAQwIRpCRdL8ca0IppwN9
         rWWK/L+DCVpNUPo38blIkgx9qrb+pe8Af/jmlirfqg0kjQ56M6v8lX/mEyoX3NPabd2l
         ILJg==
X-Gm-Message-State: ACgBeo1YgANgtH8BlsgEdNQ+lVcxjktJGGBA/YRQ2Ly024p87OIt7OOk
        gFWfn9t1a4abv9AiEXBrEUwOqvzcsrX9fPoN5Ujw
X-Google-Smtp-Source: AA6agR4Ob3wrFXNq0lbi4ZBKorbO96qfBYhxpq6MCQSqPYh19KoZvSFY8C8je4fdv+xVXZ0Za8MlHnQo/W3vk8xsKCY=
X-Received: by 2002:a81:1147:0:b0:32f:d4a5:1ab0 with SMTP id
 68-20020a811147000000b0032fd4a51ab0mr13787505ywr.438.1660678250326; Tue, 16
 Aug 2022 12:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220802185534.735338-1-jackyli@google.com> <20220802185534.735338-3-jackyli@google.com>
 <5f52ffe6-03a4-a5bf-9c57-2c3951922a35@amd.com>
In-Reply-To: <5f52ffe6-03a4-a5bf-9c57-2c3951922a35@amd.com>
From:   Jacky Li <jackyli@google.com>
Date:   Tue, 16 Aug 2022 12:30:39 -0700
Message-ID: <CAJxe5cu=gB3-urLEVShDH_-2vmB2Q=FDAtBdcTVn=oaxTAjykg@mail.gmail.com>
Subject: Re: [PATCH 2/2] crypto: ccp - Fail the PSP initialization when
 writing psp data file failed
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Marc Orr <marcorr@google.com>, Alper Gun <alpergun@google.com>,
        Peter Gonda <pgonda@google.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 1:37 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 8/2/22 13:55, Jacky Li wrote:
> > Currently the OS continues the PSP initialization when there is a write
> > failure to the init_ex_file. Therefore, the userspace would be told that
> > SEV is properly INIT'd even though the psp data file is not updated.
> > This is problematic because later when asked for the SEV data, the OS
> > won't be able to provide it.
> >
> > Fixes: 3d725965f836 ("crypto: ccp - Add SEV_INIT_EX support")
> > Reported-by: Peter Gonda <pgonda@google.com>
> > Signed-off-by: Jacky Li <jackyli@google.com>
> > ---
> >   drivers/crypto/ccp/sev-dev.c | 23 +++++++++++++----------
> >   1 file changed, 13 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> > index 5bb2ae250d38..fd6bb01eb198 100644
> > --- a/drivers/crypto/ccp/sev-dev.c
> > +++ b/drivers/crypto/ccp/sev-dev.c
> > @@ -233,7 +233,7 @@ static int sev_read_init_ex_file(void)
> >       return 0;
> >   }
> >
> > -static void sev_write_init_ex_file(void)
> > +static int sev_write_init_ex_file(void)
> >   {
> >       struct sev_device *sev = psp_master->sev_data;
> >       struct file *fp;
> > @@ -243,14 +243,15 @@ static void sev_write_init_ex_file(void)
> >       lockdep_assert_held(&sev_cmd_mutex);
> >
> >       if (!sev_init_ex_buffer)
> > -             return;
> > +             return 0;
> >
> >       fp = open_file_as_root(init_ex_path, O_CREAT | O_WRONLY, 0600);
> >       if (IS_ERR(fp)) {
> > +             int ret = PTR_ERR(fp);
>
> Please put a blank line after the variable declaration.
>

Will do in the v2. Thanks for the reminder!

> >               dev_err(sev->dev,
> >                       "SEV: could not open file for write, error %ld\n",
> > -                     PTR_ERR(fp));
> > -             return;
> > +                     ret);
>
> You'll need to fix the kernel test robot report here.
>
> Thanks,
> Tom
>

Will change %ld to %d in v2. Thanks!

Thanks,
Jacky




> > +             return ret;
> >       }
> >
> >       nwrite = kernel_write(fp, sev_init_ex_buffer, NV_LENGTH, &offset);
> > @@ -261,18 +262,20 @@ static void sev_write_init_ex_file(void)
> >               dev_err(sev->dev,
> >                       "SEV: failed to write %u bytes to non volatile memory area, ret %ld\n",
> >                       NV_LENGTH, nwrite);
> > -             return;
> > +             return -EIO;
> >       }
> >
> >       dev_dbg(sev->dev, "SEV: write successful to NV file\n");
> > +
> > +     return 0;
> >   }
> >
> > -static void sev_write_init_ex_file_if_required(int cmd_id)
> > +static int sev_write_init_ex_file_if_required(int cmd_id)
> >   {
> >       lockdep_assert_held(&sev_cmd_mutex);
> >
> >       if (!sev_init_ex_buffer)
> > -             return;
> > +             return 0;
> >
> >       /*
> >        * Only a few platform commands modify the SPI/NV area, but none of the
> > @@ -287,10 +290,10 @@ static void sev_write_init_ex_file_if_required(int cmd_id)
> >       case SEV_CMD_PEK_GEN:
> >               break;
> >       default:
> > -             return;
> > +             return 0;
> >       }
> >
> > -     sev_write_init_ex_file();
> > +     return sev_write_init_ex_file();
> >   }
> >
> >   static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
> > @@ -363,7 +366,7 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
> >                       cmd, reg & PSP_CMDRESP_ERR_MASK);
> >               ret = -EIO;
> >       } else {
> > -             sev_write_init_ex_file_if_required(cmd);
> > +             ret = sev_write_init_ex_file_if_required(cmd);
> >       }
> >
> >       print_hex_dump_debug("(out): ", DUMP_PREFIX_OFFSET, 16, 2, data,
