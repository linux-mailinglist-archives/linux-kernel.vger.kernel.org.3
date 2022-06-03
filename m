Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9799A53C25A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240995AbiFCBsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 21:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbiFCBsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 21:48:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650FF26575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 18:48:21 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e2so8604114wrc.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 18:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QNli7KEh4KKbtSkzKBTNfjO3jAVOCO2dCudSxyTimLk=;
        b=FmtcCWUd8fN1FKAhCyeHgUZwJRgKg6GYUBx5XO7/O41qJaghWhaymr2HRHB0xz3zSM
         cUsn30llFmwSdxsTHGZIGfMNSWgdgAZCr9Czhl9lrw7AGD3yXQWfwxmk22CSndaF3V4V
         Qi7z3HypVIwhCP6y11i9wVDAf7ZoXtzt/MmcUICEY3r97taqKd1ahMoNmH9Ay2O9UTxk
         VuHbEhIaEFRFr8quImFfNeOVKneWbIOcheNgJ5Ryfpd1HT1cTgByPAnbwwFONo/eLVb8
         EqOBE7C0tg6RaH5czdwl9OdxnwpASKc+K+v6UzM+pahRinxy5Tn/zOTJBejO00H6E7SF
         8yGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QNli7KEh4KKbtSkzKBTNfjO3jAVOCO2dCudSxyTimLk=;
        b=mB31n1DygIP4bID+/T+1/biH6ZctREwx0OWaWfOnNU1N1neYksAkYycQVyBybQBdC6
         VwI+wU9MJhzofrlur2HKlI4Zj9GOEsEQBqvq6cjUckL7gge7ox0Gi4/I1DwsA3bpfzlj
         kekt7DeTZ7+oibaeGPzqkXb4Ob0yOrwmyEmisefrCosj3vSLYamXClU6yyCULauqDXnL
         JKrnYGwSDyRAmmNqrDmVqDtdFc+zG+mU+tqOSv9GyBPPuqRlgp3q6Zgm0KlHfcBqT5qa
         bW30WfRZbzDlR7m8bw1diQlLgo8jpQFfOxxHnOlk3oFjJgIB7SQ3hHHR4cN4edfPaWWF
         /NjQ==
X-Gm-Message-State: AOAM532tH70TC8ma0JmRHDHVJh6ZCQlRONITHdrqJd5ktDArIBTVs8dL
        oqUctnYuzlcbDc4i9GSjvxIxzxu/hf5kjZ8SHqQ=
X-Google-Smtp-Source: ABdhPJyztN3ZAGjzK/SDIoRSTndoMFe05zD8gn7lUuFMJS50+raT2K1CrB8lK7ntDRcYyJdjc7fHK7MoEGhvc1Kl4Z8=
X-Received: by 2002:a05:6000:1788:b0:20c:a43c:10fa with SMTP id
 e8-20020a056000178800b0020ca43c10famr5954950wrg.511.1654220899886; Thu, 02
 Jun 2022 18:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220602164518.286295-2-xiehuan09@gmail.com> <202206030515.4lqqkb3W-lkp@intel.com>
In-Reply-To: <202206030515.4lqqkb3W-lkp@intel.com>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Fri, 3 Jun 2022 09:48:07 +0800
Message-ID: <CAEr6+ED6oJV1BmAQy6T592GX751t9QB==0vWcXUDMw3WL0YWtA@mail.gmail.com>
Subject: Re: [PATCH v11 1/4] trace: Add trace any kernel object
To:     kernel test robot <lkp@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, mingo@redhat.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi lkp,

On Fri, Jun 3, 2022 at 5:12 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Jeff,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on b39181f7c6907dc66ff937b74758671fa6ba430c]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jeff-Xie/trace-Int=
roduce-objtrace-trigger-to-trace-the-kernel-object/20220603-004723
> base:   b39181f7c6907dc66ff937b74758671fa6ba430c
> config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/202=
20603/202206030515.4lqqkb3W-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b364=
c76683f8ef241025a9556300778c07b590c2)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/765253f020469f948=
56aedc5a3fe5444e1e8f4e8
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review Jeff-Xie/trace-Introduce-objtrac=
e-trigger-to-trace-the-kernel-object/20220603-004723
>         git checkout 765253f020469f94856aedc5a3fe5444e1e8f4e8
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=
=3D1 O=3Dbuild_dir ARCH=3Di386 SHELL=3D/bin/bash drivers/gpu/drm/qxl/ kerne=
l/trace/
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> kernel/trace/trace_object.c:336:61: warning: format specifies type 'lo=
ng' but the argument has type 'unsigned int' [-Wformat]
>                    pr_err("the size of the %s should be:%ld\n", field->na=
me, sizeof(void *));
>                                                         ~~~              =
    ^~~~~~~~~~~~~~
>                                                         %u

I will  double check it ,the sizeof(void *) on x86_64 is type =E2=80=98long
unsigned int=E2=80=99.

>    include/linux/printk.h:489:33: note: expanded from macro 'pr_err'
>            printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>                                   ~~~     ^~~~~~~~~~~
>    include/linux/printk.h:446:60: note: expanded from macro 'printk'
>    #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__=
)
>                                                        ~~~    ^~~~~~~~~~~
>    include/linux/printk.h:418:19: note: expanded from macro 'printk_index=
_wrap'
>                    _p_func(_fmt, ##__VA_ARGS__);                         =
  \
>                            ~~~~    ^~~~~~~~~~~
>    1 warning generated.
>
>
> vim +336 kernel/trace/trace_object.c
>
>    297
>    298  static int
>    299  event_object_trigger_parse(struct event_command *cmd_ops,
>    300                         struct trace_event_file *file,
>    301                         char *glob, char *cmd, char *param_and_fil=
ter)
>    302  {
>    303          struct event_trigger_data *trigger_data;
>    304          struct objtrace_trigger_data *obj_data;
>    305          struct ftrace_event_field *field;
>    306          char *objtrace_cmd, *arg;
>    307          char *param, *filter;
>    308          int ret;
>    309          bool remove;
>    310
>    311          remove =3D event_trigger_check_remove(glob);
>    312
>    313          /*
>    314           * separate the param and the filter:
>    315           * objtrace:add:OBJ[:COUNT] [if filter]
>    316           */
>    317          ret =3D event_trigger_separate_filter(param_and_filter, &=
param, &filter, true);
>    318          if (ret)
>    319                  return ret;
>    320
>    321          objtrace_cmd =3D strsep(&param, ":");
>    322          if (!objtrace_cmd || strcmp(objtrace_cmd, OBJTRACE_CMD_AD=
D)) {
>    323                  pr_err("error objtrace command\n");
>    324                  return -EINVAL;
>    325          }
>    326
>    327          arg =3D strsep(&param, ":");
>    328          if (!arg)
>    329                  return -EINVAL;
>    330
>    331          field =3D trace_find_event_field(file->event_call, arg);
>    332          if (!field)
>    333                  return -EINVAL;
>    334
>    335          if (field->size !=3D sizeof(void *)) {
>  > 336                  pr_err("the size of the %s should be:%ld\n", fiel=
d->name, sizeof(void *));
>    337                  return -EINVAL;
>    338          }
>    339
>    340          if (remove && !field_exist(file, cmd_ops, field->name))
>    341                  return -ENOENT;
>    342
>    343          obj_data =3D kzalloc(sizeof(*obj_data), GFP_KERNEL);
>    344          if (!obj_data)
>    345                  return -ENOMEM;
>    346
>    347          obj_data->field =3D field;
>    348          obj_data->tr =3D file->tr;
>    349          snprintf(obj_data->objtrace_cmd, OBJTRACE_CMD_LEN, objtra=
ce_cmd);
>    350
>    351          trigger_data =3D event_trigger_alloc(cmd_ops, cmd, param,=
 obj_data);
>    352          if (!trigger_data) {
>    353                  kfree(obj_data);
>    354                  return -ENOMEM;
>    355          }
>    356          if (remove) {
>    357                  event_trigger_unregister(cmd_ops, file, glob+1, t=
rigger_data);
>    358                  kfree(obj_data);
>    359                  kfree(trigger_data);
>    360                  return 0;
>    361          }
>    362
>    363          ret =3D event_trigger_parse_num(param, trigger_data);
>    364          if (ret)
>    365                  goto out_free;
>    366
>    367          ret =3D event_trigger_set_filter(cmd_ops, file, filter, t=
rigger_data);
>    368          if (ret < 0)
>    369                  goto out_free;
>    370
>    371          ret =3D event_trigger_register(cmd_ops, file, glob, trigg=
er_data);
>    372          if (ret)
>    373                  goto out_free;
>    374
>    375          return ret;
>    376
>    377   out_free:
>    378          event_trigger_reset_filter(cmd_ops, trigger_data);
>    379          kfree(obj_data);
>    380          kfree(trigger_data);
>    381          return ret;
>    382  }
>    383
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

Thanks,
JeffXie
