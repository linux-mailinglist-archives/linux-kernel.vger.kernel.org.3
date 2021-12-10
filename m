Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9762347010E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241378AbhLJNCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:02:16 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41527 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbhLJNCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:02:15 -0500
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id BE07DE0007;
        Fri, 10 Dec 2021 12:58:36 +0000 (UTC)
Date:   Fri, 10 Dec 2021 13:59:29 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Eugen.Hristev@microchip.com
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@iki.fi,
        Nicolas.Ferre@microchip.com
Subject: Re: [PATCH v2 03/25] media: atmel: introduce microchip csi2dc driver
Message-ID: <20211210125929.uykudrsjo6bm3v4d@uno.localdomain>
References: <20211112142509.2230884-1-eugen.hristev@microchip.com>
 <20211112142509.2230884-4-eugen.hristev@microchip.com>
 <20211206105142.chmrks6sueohw7sx@uno.localdomain>
 <1fca04a4-ab5c-15cc-61ab-829d39a63ec8@microchip.com>
 <20211206120630.mlciq2662azznesu@uno.localdomain>
 <3d5cf51e-3ea0-9fff-b9f8-cd0eadb4ea2b@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d5cf51e-3ea0-9fff-b9f8-cd0eadb4ea2b@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Eugen

On Fri, Dec 10, 2021 at 11:07:15AM +0000, Eugen.Hristev@microchip.com wrote:
> On 12/6/21 2:06 PM, Jacopo Mondi wrote:
> > Hi Eugen
> >
> > On Mon, Dec 06, 2021 at 11:42:25AM +0000, Eugen.Hristev@microchip.com wrote:
> >> On 12/6/21 12:51 PM, Jacopo Mondi wrote:
> >>> Hello Eugen
> >>>
> >>>       thanks for addressing all my previous comments, just a few more
> >>>       things and the driver looks good to me
> >>
> >> Thanks for reviewing. I tried my best to accomodate your suggestions.
> >>>
> >>> On Fri, Nov 12, 2021 at 04:24:47PM +0200, Eugen Hristev wrote:

[snip]

> >>>> +
> >>>> +static int csi2dc_probe(struct platform_device *pdev)
> >>>> +{
> >>>> +     struct device *dev = &pdev->dev;
> >>>> +     struct csi2dc_device *csi2dc;
> >>>> +     int ret = 0;
> >>>> +     u32 ver;
> >>>> +
> >>>> +     csi2dc = devm_kzalloc(dev, sizeof(*csi2dc), GFP_KERNEL);
> >>>> +     if (!csi2dc)
> >>>> +             return -ENOMEM;
> >>>> +
> >>>> +     csi2dc->dev = dev;
> >>>> +
> >>>> +     csi2dc->base = devm_platform_ioremap_resource(pdev, 0);
> >>>> +     if (IS_ERR(csi2dc->base)) {
> >>>> +             dev_err(dev, "base address not set\n");
> >>>> +             return PTR_ERR(csi2dc->base);
> >>>> +     }
> >>>> +
> >>>> +     csi2dc->pclk = devm_clk_get(dev, "pclk");
> >>>> +     if (IS_ERR(csi2dc->pclk)) {
> >>>> +             ret = PTR_ERR(csi2dc->pclk);
> >>>> +             dev_err(dev, "failed to get pclk: %d\n", ret);
> >>>> +             return ret;
> >>>> +     }
> >>>> +
> >>>> +     csi2dc->scck = devm_clk_get(dev, "scck");
> >>>> +     if (IS_ERR(csi2dc->scck)) {
> >>>> +             ret = PTR_ERR(csi2dc->scck);
> >>>> +             dev_err(dev, "failed to get scck: %d\n", ret);
> >>>> +             return ret;
> >>>> +     }
> >>>> +
> >>>> +     v4l2_subdev_init(&csi2dc->csi2dc_sd, &csi2dc_subdev_ops);
> >>>> +
> >>>> +     csi2dc->csi2dc_sd.owner = THIS_MODULE;
> >>>> +     csi2dc->csi2dc_sd.dev = dev;
> >>>> +     snprintf(csi2dc->csi2dc_sd.name, sizeof(csi2dc->csi2dc_sd.name),
> >>>> +              "csi2dc");
> >>>> +
> >>>> +     csi2dc->csi2dc_sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
> >>>> +     csi2dc->csi2dc_sd.entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
> >>>> +
> >>>> +     platform_set_drvdata(pdev, csi2dc);
> >>>> +
> >>>> +     ret = csi2dc_of_parse(csi2dc, dev->of_node);
> >>>> +     if (ret)
> >>>> +             goto csi2dc_probe_cleanup_entity;
> >>>> +
> >>>> +     csi2dc->pads[CSI2DC_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
> >>>> +     if (csi2dc->video_pipe)
> >>>> +             csi2dc->pads[CSI2DC_PAD_SOURCE].flags = MEDIA_PAD_FL_SOURCE;
> >>>> +
> >>>> +     ret = media_entity_pads_init(&csi2dc->csi2dc_sd.entity,
> >>>> +                                  csi2dc->video_pipe ? CSI2DC_PADS_NUM : 1,
> >>>> +                                  csi2dc->pads);
> >>>> +     if (ret < 0) {
> >>>> +             dev_err(dev, "media entity init failed\n");
> >>>> +             goto csi2dc_probe_cleanup_notifier;
> >>>> +     }
> >>>> +
> >>>> +     csi2dc_default_format(csi2dc);
> >>>> +
> >>>> +     /* turn power on to validate capabilities */
> >>>> +     ret = csi2dc_power(csi2dc, true);
> >>>> +     if (ret < 0)
> >>>> +             goto csi2dc_probe_cleanup_notifier;
> >>>> +
> >>>> +     pm_runtime_set_active(dev);
> >>>> +     pm_runtime_enable(dev);
> >>>> +     ver = csi2dc_readl(csi2dc, CSI2DC_VERSION);
> >>>
> >>> Shouldn't you verify that the version is the expected one, or that, at
> >>> least the device can be accessed ?
> >>
> >> If the read from the register worked, the device can be accessed. If the
> >> device won't respond to this, we will get a bus fault or a freeze.
> >> And printing the version number can help all the time by inspecting the
> >> bootlog to see if something valid was printed.
> >> Version changes from product to product but seeing a bootlog later will
> >> make us easily understand which product was it, and if the version was
> >> read correctly
> >>
> >>>
> >>>> +     pm_request_idle(dev);
> >>>
> >>> I'm not well versed when it comes to runtime_pm but I can read that
> >>>
> >>> Documentation/power/runtime_pm.rst-  `int pm_request_idle(struct device *dev);`
> >>> Documentation/power/runtime_pm.rst-    - submit a request to execute the subsystem-level idle callback for the
> >>> Documentation/power/runtime_pm.rst-      device (the request is represented by a work item in pm_wq); returns 0 on
> >>> Documentation/power/runtime_pm.rst-      success or error code if the request has not been queued up
> >>>
> >>> And looking below you have
> >>>
> >>> +static const struct dev_pm_ops csi2dc_dev_pm_ops = {
> >>> +       SET_RUNTIME_PM_OPS(csi2dc_runtime_suspend, csi2dc_runtime_resume, NULL)
> >>> +};
> >>>
> >>> Which expands to
> >>>
> >>> include/linux/pm.h:     SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
> >>>
> >>> so it seems to me you've no idle func defined, hence you above call
> >>> has no effect so you're device stays powered on after your above call
> >>> to
> >>>
> >>>           ret = csi2dc_power(csi2dc, true);
> >>>
> >>> Also trying to suspend using runtime_pm while having powered on by
> >>> calling the resume function directly would leave the pm status
> >>> unbalanced ?
> >>>
> >>> I would raher call pm_runtime_resume() and
> >>> pm_runtime_suspend() or call the power routine directly, and later
> >>> enable pm_runtime
> >>>
> >>>           csi2dc_power(true)
> >>>           readl();
> >>>           csi2fd_power(false);
> >>>
> >>>           pm_runtime_set_active();
> >>>           pm_runtime_enable();
> >>>
> >>>           v4l2_async_register();
> >>>
> >>> Again, not well versed in runtime_pm, so don't assume the above makes
> >>> sense :)
> >>
> >> I am not versed in runtime_pm either, I will try to remove this
> >> 'pm_request_idle' to see what happens at the first
> >> pm_runtime_resume_and_get, and print messages in power on/power off to
> >> see how and when they are called.
> >>
> >
>
>
> Hi Jacopo,
>
> I added traces in my power on / power off functions to see who calls them.
>
> Here is the log :
>
> power on
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at
> drivers/media/platform/atmel/microchip-csi2dc.c:331 csi2dc_power+0xd0/0x134
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper Not tainted 5.16.0-rc4+ #62
> Hardware name: Microchip SAMA7
> [<c010b9dc>] (unwind_backtrace) from [<c010975c>] (show_stack+0x10/0x14)
> [<c010975c>] (show_stack) from [<c0755aa0>] (__warn+0xd0/0x128)
> [<c0755aa0>] (__warn) from [<c0755b70>] (warn_slowpath_fmt+0x78/0xac)
> [<c0755b70>] (warn_slowpath_fmt) from [<c0501114>] (csi2dc_power+0xd0/0x134)
> [<c0501114>] (csi2dc_power) from [<c05012dc>] (csi2dc_probe+0x158/0x23c)
> [<c05012dc>] (csi2dc_probe) from [<c04067cc>] (platform_probe+0x5c/0xb8)
> [<c04067cc>] (platform_probe) from [<c04043f8>]
> (really_probe.part.0+0x9c/0x32c)
> [<c04043f8>] (really_probe.part.0) from [<c0404730>]
> (__driver_probe_device+0xa8/0x13c)
> [<c0404730>] (__driver_probe_device) from [<c04047f8>]
> (driver_probe_device+0x34/0x108)
> [<c04047f8>] (driver_probe_device) from [<c0404ea0>]
> (__driver_attach+0xb4/0x180)
> [<c0404ea0>] (__driver_attach) from [<c040245c>]
> (bus_for_each_dev+0x74/0xc0)
> [<c040245c>] (bus_for_each_dev) from [<c0403804>]
> (bus_add_driver+0x15c/0x1e0)
> [<c0403804>] (bus_add_driver) from [<c040572c>] (driver_register+0x8c/0x124)
> [<c040572c>] (driver_register) from [<c01014b0>]
> (do_one_initcall+0x54/0x1d0)
> [<c01014b0>] (do_one_initcall) from [<c0b0114c>]
> (kernel_init_freeable+0x19c/0x200)
> [<c0b0114c>] (kernel_init_freeable) from [<c075c9e0>]
> (kernel_init+0x18/0x128)
> [<c075c9e0>] (kernel_init) from [<c0100140>] (ret_from_fork+0x14/0x34)
> Exception stack(0xc4033fb0 to 0xc4033ff8)
> 3fa0:                                     00000000 00000000 00000000
> 00000000
> 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000
> 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> ---[ end trace a5faddd6c4e11ca2 ]---
> microchip-csi2dc e1404000.csi2dc: Microchip CSI2DC version 145
> power off
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 28 at
> drivers/media/platform/atmel/microchip-csi2dc.c:335
> csi2dc_runtime_suspend+0x34/0x6c
> Modules linked in:
> CPU: 0 PID: 28 Comm: kworker/0:9 Tainted: G        W         5.16.0-rc4+ #62
> Hardware name: Microchip SAMA7
> Workqueue: pm pm_runtime_work
> [<c010b9dc>] (unwind_backtrace) from [<c010975c>] (show_stack+0x10/0x14)
> [<c010975c>] (show_stack) from [<c0755aa0>] (__warn+0xd0/0x128)
> [<c0755aa0>] (__warn) from [<c0755b70>] (warn_slowpath_fmt+0x78/0xac)
> [<c0755b70>] (warn_slowpath_fmt) from [<c075b4cc>]
> (csi2dc_runtime_suspend+0x34/0x6c)
> [<c075b4cc>] (csi2dc_runtime_suspend) from [<c04114b8>]
> (__rpm_callback+0x30/0xe4)
> [<c04114b8>] (__rpm_callback) from [<c04115cc>] (rpm_callback+0x60/0x64)
> [<c04115cc>] (rpm_callback) from [<c0410e28>] (rpm_suspend+0xd0/0x4bc)
> [<c0410e28>] (rpm_suspend) from [<c041244c>] (pm_runtime_work+0x90/0x98)
> [<c041244c>] (pm_runtime_work) from [<c012b568>]
> (process_one_work+0x198/0x410)
> [<c012b568>] (process_one_work) from [<c012b85c>] (worker_thread+0x7c/0x570)
> [<c012b85c>] (worker_thread) from [<c0132168>] (kthread+0x154/0x174)
> [<c0132168>] (kthread) from [<c0100140>] (ret_from_fork+0x14/0x34)
> Exception stack(0xc4327fb0 to 0xc4327ff8)
> 7fa0:                                     00000000 00000000 00000000
> 00000000
> 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000
> 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> ---[ end trace a5faddd6c4e11ca3 ]---
> >
>
>
> So it looks like after probing is finished, the runtime PM system
> switches the device back to suspend mode (as probably there are no 'get'
> operations on it ).
>
> I removed the pm_request_idle as it looks you are right, it does nothing.
>
> When trying to capture a frame, this happens:
>
> # cam -c1 -C1
> [0:01:14.779664000] [229]  INFO IPAManager ipa_manager.cpp:138 libcamera
> is not installed. Adding '//src/ipa' to the IPA search path
> [0:01:14.784039600] [229]  WARN IPAManager ipa_manager.cpp:149 No IPA
> found in '/usr/lib/libcamera'
> [0:01:14.784219400] [229]  INFO Camera camera_manager.cpp:293 libcamera
> v0.0.0+60036-2021.11-rc1-182-gd72a7997-dirty (2021-11-15T11:27:09+02:00)
> [0:01:14.800801800] [230]  WARN CameraSensor camera_sensor.cpp:197
> 'imx219 1-0010': Recommended V4L2 control 0x009a0922 not supported
> [0:01:14.800952200] [230]  WARN CameraSensor camera_sensor.cpp:249
> 'imx219 1-0010': The sensor kernel driver needs to be fixed
> [0:01:14.801018400] [230]  WARN CameraSensor camera_sensor.cpp:251
> 'imx219 1-0010': See Documentation/sensor_driver_requirements.rst in the
> libcamera sources for more information
> [0:01:14.803197200] [230]  WARN CameraSensor camera_sensor.cpp:414
> 'imx219 1-0010': Failed to retrieve the camera location
> [0:01:14.805444000] [230]  WARN V4L2 v4l2_pixelformat.cpp:287
> Unsupported V4L2 pixel format Y16
> [0:01:14.805541200] [230]  WARN V4L2 v4l2_pixelformat.cpp:287
> Unsupported V4L2 pixel format AR12
> [0:01:14.805612200] [230]  WARN V4L2 v4l2_pixelformat.cpp:287
> Unsupported V4L2 pixel format AR15
> Using camera /base/soc/flexcom@e2818000/i2c@600/camera@10 as cam0
> [0:01:14.806657000] [229]  INFO Camera camera.cpp:945 configuring
> streams: (0) 3264x2464-R8
> power on
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 230 at
> drivers/media/platform/atmel/microchip-csi2dc.c:331 csi2dc_power+0xd0/0x134
> Modules linked in: imx219 dw_csi dw_dphy
> CPU: 0 PID: 230 Comm: cam Tainted: G        W         5.16.0-rc4+ #63
> Hardware name: Microchip SAMA7
> [<c010b9dc>] (unwind_backtrace) from [<c010975c>] (show_stack+0x10/0x14)
> [<c010975c>] (show_stack) from [<c0755aa0>] (__warn+0xd0/0x128)
> [<c0755aa0>] (__warn) from [<c0755b70>] (warn_slowpath_fmt+0x78/0xac)
> [<c0755b70>] (warn_slowpath_fmt) from [<c0501114>] (csi2dc_power+0xd0/0x134)
> [<c0501114>] (csi2dc_power) from [<c04114b8>] (__rpm_callback+0x30/0xe4)
> [<c04114b8>] (__rpm_callback) from [<c04115cc>] (rpm_callback+0x60/0x64)
> [<c04115cc>] (rpm_callback) from [<c0411984>] (rpm_resume+0x3b4/0x550)
> [<c0411984>] (rpm_resume) from [<c0411b54>] (__pm_runtime_resume+0x34/0x3c)
> [<c0411b54>] (__pm_runtime_resume) from [<c0500dcc>]
> (csi2dc_s_stream+0xb8/0x330)
> [<c0500dcc>] (csi2dc_s_stream) from [<c04fee9c>]
> (isc_start_streaming+0x3a4/0x498)
> [<c04fee9c>] (isc_start_streaming) from [<c04f5280>]
> (vb2_start_streaming+0x98/0x1a8)
> [<c04f5280>] (vb2_start_streaming) from [<c04f57d0>]
> (vb2_core_qbuf+0x440/0x5d4)
> [<c04f57d0>] (vb2_core_qbuf) from [<c04f9490>] (vb2_qbuf+0x80/0xdc)
> [<c04f9490>] (vb2_qbuf) from [<c04dd0dc>] (__video_do_ioctl+0x234/0x490)
> [<c04dd0dc>] (__video_do_ioctl) from [<c04de410>]
> (video_usercopy+0x1b4/0x550)
> [<c04de410>] (video_usercopy) from [<c01e77b8>] (sys_ioctl+0x224/0xa0c)
> [<c01e77b8>] (sys_ioctl) from [<c0100060>] (ret_fast_syscall+0x0/0x50)
> Exception stack(0xc46e7fa8 to 0xc46e7ff0)
> 7fa0:                   b5d07088 b5d113c8 00000011 c044560f b66da594
> b6e14000
> 7fc0: b5d07088 b5d113c8 b66da594 00000036 b66da5d8 fffffff8 b66da6cc
> b66da8e0
> 7fe0: b6fb63a8 b66da57c b6f70d88 b6ba9fec
> ---[ end trace 7204e1871cae96e7 ]---
> cam0dw-csi e1400000.csi2host: number of lanes: 2
>
> phy phy-e1400040.dphy.0: PHY Stop state not reached 0
> 75.378082power off
>   ------------[ cut here ]----e-------
> 4WARNING: CPU: 0 PID: 230 at
> drivers/media/platform/atmel/microchip-csi2dc.c:335
> csi2dc_runtime_suspend+0x34/0x6c
> Modules linked in: imx219 dw_csi dw_dphy
> CPU: 0 PID: 230 Comm: cam Tainted: G        W         5.16.0-rc4+ #63
> Hardware name: Microchip SAMA7
> [<c010b9dc>] (unwind_backtrace) from [<c010975c>] (show_stack+0x10/0x14)
> [<c010975c>] (show_stack) from [<c0755aa0>] (__warn+0xd0/0x128)
> [<c0755aa0>] (__warn) from [<c0755b70>] (warn_slowpath_fmt+0x78/0xac)
> [<c0755b70>] (warn_slowpath_fmt) from [<c075b4cc>]
> (csi2dc_runtime_suspend+0x34/0x6c)
> [<c075b4cc>] (csi2dc_runtime_suspend) from [<c04114b8>]
> (__rpm_callback+0x30/0xe4)
> [<c04114b8>] (__rpm_callback) from [<c04115cc>] (rpm_callback+0x60/0x64)
> [<c04115cc>] (rpm_callback) from [<c0410e28>] (rpm_suspend+0xd0/0x4bc)
> [<c0410e28>] (rpm_suspend) from [<c041136c>] (__pm_runtime_idle+0x3c/0x4c)
> [<c041136c>] (__pm_runtime_idle) from [<c0500d98>]
> (csi2dc_s_stream+0x84/0x330)
> [<c0500d98>] (csi2dc_s_stream) from [<c04fcc7c>]
> (isc_stop_streaming+0x134/0x174)
> [<c04fcc7c>] (isc_stop_streaming) from [<c04f5dd8>]
> (__vb2_queue_cancel+0x28/0x2a4)
> [<c04f5dd8>] (__vb2_queue_cancel) from [<c04f606c>]
> (vb2_core_streamoff+0x18/0xac)
> [<c04f606c>] (vb2_core_streamoff) from [<c04dd0dc>]
> (__video_do_ioctl+0x234/0x490)
> [<c04dd0dc>] (__video_do_ioctl) from [<c04de410>]
> (video_usercopy+0x1b4/0x550)
> [<c04de410>] (video_usercopy) from [<c01e77b8>] (sys_ioctl+0x224/0xa0c)
> [<c01e77b8>] (sys_ioctl) from [<c0100060>] (ret_fast_syscall+0x0/0x50)
> Exception stack(0xc46e7fa8 to 0xc46e7ff0)
> 7fa0:                   b5d07088 b6fb5d58 00000011 40045613 b5d071bc
> 00000001
> 7fc0: b5d07088 b6fb5d58 b5d01e20 00000036 b5d008b8 00000000 b5d01e20
> 0054ec00
> 7fe0: b6fb63a8 b66da7b4 b6f70d88 b6ba9fec
> ---[ end trace 7204e1871cae96e8 ]---
> #
> #
>
> Which is expected, on start streaming, the power on is called, and on
> stop streaming the power off.
>
>
> So it looks like the driver does pm_runtime_set_active, meaning the
> power state is active (which is something that I do by calling first
> csi2dc_power(true)), and after probing is done, it's automatically sent
> to suspend mode.
>
> So if I do csi2dc_power(false) before finish probing, there will be a
> problem because it will be called again by the subsystem, leading to
> issues with double clock unpreparing... etc.
>
> So you are fine with this sequence?
>
> ..init this..
> ..init that..
> csi2dc_power(true)
> readl();
>
> pm_runtime_set_active();
> pm_runtime_enable();
>
> ..finish probing..
>

Thanks for the detailed analysis !

If it all works like it's expected and the device gets powered off
after probe and works well at s_stream() time, I'm of course ok with
that :)

Thanks


>
> Thanks again,
> Eugen
>
>
> >>
> >>>
> >>>> +
> >>>> +     /*
> >>>> +      * we must register the subdev after PM runtime has been requested,
> >>>> +      * otherwise we might bound immediately and request pm_runtime_resume
> >>>> +      * before runtime_enable.
> >>>> +      */
> >>>> +     ret = v4l2_async_register_subdev(&csi2dc->csi2dc_sd);
> >>>> +     if (ret) {
> >>>> +             dev_err(csi2dc->dev, "failed to register the subdevice\n");
> >>>> +             goto csi2dc_probe_cleanup_notifier;
> >>>> +     }
> >>>> +
> >>>> +     dev_info(dev, "Microchip CSI2DC version %x\n", ver);
> >>>> +
> >>>> +     return 0;
> >>>> +
> >>>> +csi2dc_probe_cleanup_notifier:
> >>>> +     v4l2_async_nf_cleanup(&csi2dc->notifier);
> >>>> +csi2dc_probe_cleanup_entity:
> >>>> +     media_entity_cleanup(&csi2dc->csi2dc_sd.entity);
> >>>
> >>> I wasn't honestly expecting this
> >>>
> >>> /**
> >>>    * media_entity_cleanup() - free resources associated with an entity
> >>>    *
> >>>    * @entity:     entity where the pads belong
> >>>    *
> >>>    * This function must be called during the cleanup phase after unregistering
> >>>    * the entity (currently, it does nothing).
> >>>    */
> >>> #if IS_ENABLED(CONFIG_MEDIA_CONTROLLER)
> >>> static inline void media_entity_cleanup(struct media_entity *entity) {}
> >>>
> >>> :)
> >>
> >> I saw it as well. But I thought that who knows, in the future it might
> >> do something, so it's better to have it in the driver rather than not
> >> have it at all.
> >>
> >>
> >> Thanks again for reviewing,
> >> Eugen
> >>
> >>>
> >>>> +
> >>>> +     return ret;
> >>>> +}
> >>>> +
> >>>> +static int csi2dc_remove(struct platform_device *pdev)
> >>>> +{
> >>>> +     struct csi2dc_device *csi2dc = platform_get_drvdata(pdev);
> >>>> +
> >>>> +     pm_runtime_disable(&pdev->dev);
> >>>> +
> >>>> +     v4l2_async_unregister_subdev(&csi2dc->csi2dc_sd);
> >>>> +     v4l2_async_nf_unregister(&csi2dc->notifier);
> >>>> +     v4l2_async_nf_cleanup(&csi2dc->notifier);
> >>>> +     media_entity_cleanup(&csi2dc->csi2dc_sd.entity);
> >>>> +
> >>>> +     return 0;
> >>>> +}
> >>>> +
> >>>> +static int __maybe_unused csi2dc_runtime_suspend(struct device *dev)
> >>>> +{
> >>>> +     struct csi2dc_device *csi2dc = dev_get_drvdata(dev);
> >>>> +
> >>>> +     return csi2dc_power(csi2dc, false);
> >>>> +}
> >>>> +
> >>>> +static int __maybe_unused csi2dc_runtime_resume(struct device *dev)
> >>>> +{
> >>>> +     struct csi2dc_device *csi2dc = dev_get_drvdata(dev);
> >>>> +
> >>>> +     return csi2dc_power(csi2dc, true);
> >>>> +}
> >>>> +
> >>>> +static const struct dev_pm_ops csi2dc_dev_pm_ops = {
> >>>> +     SET_RUNTIME_PM_OPS(csi2dc_runtime_suspend, csi2dc_runtime_resume, NULL)
> >>>> +};
> >>>> +
> >>>> +static const struct of_device_id csi2dc_of_match[] = {
> >>>> +     { .compatible = "microchip,sama7g5-csi2dc" },
> >>>> +     { }
> >>>> +};
> >>>> +
> >>>> +MODULE_DEVICE_TABLE(of, csi2dc_of_match);
> >>>> +
> >>>> +static struct platform_driver csi2dc_driver = {
> >>>> +     .probe  = csi2dc_probe,
> >>>> +     .remove = csi2dc_remove,
> >>>> +     .driver = {
> >>>> +             .name =                 "microchip-csi2dc",
> >>>> +             .pm =                   &csi2dc_dev_pm_ops,
> >>>> +             .of_match_table =       of_match_ptr(csi2dc_of_match),
> >>>> +     },
> >>>> +};
> >>>> +
> >>>> +module_platform_driver(csi2dc_driver);
> >>>> +
> >>>> +MODULE_AUTHOR("Eugen Hristev <eugen.hristev@microchip.com>");
> >>>> +MODULE_DESCRIPTION("Microchip CSI2 Demux Controller driver");
> >>>> +MODULE_LICENSE("GPL v2");
> >>>> --
> >>>> 2.25.1
> >>>>
> >>
>
